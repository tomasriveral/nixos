{self, ...}: {
  flake.nixosModules.kdrive-laptop = {pkgs-unstable, ...}: {
    environment.systemPackages = with pkgs-unstable; [
      rclone
      self.packages.${pkgs.system}.custom-checkKdrive
      self.packages.${pkgs.system}.custom-mountkdrive-laptop
    ];
    # removes rclone error
    programs.fuse = {
      userAllowOther = true;
      enable = true;
    };
  };
  flake.nixosModules.kdrive-desktop = {pkgs-unstable, ...}: {
    environment.systemPackages = with pkgs-unstable; [
      rclone
      icloudpd
      self.packages.${pkgs-unstable.system}.custom-checkKdrive
      self.packages.${pkgs-unstable.system}.custom-synckdrive-desktop
    ];
    # removes rclone error
    programs.fuse = {
      userAllowOther = true;
      enable = true;
    };
    systemd.user.services.kdrive-sync = {
      serviceConfig = {
        ExecStart = "${self.packages.${pkgs-unstable.system}.custom-synckdrive-desktop}/bin/custom-synckdrive";

        Nice = 19; # lowest CPU scheduling priority
        IOSchedulingClass = "idle";
        IOSchedulingPriority = 7;

        # Optional:
        CPUWeight = 1; # minimum relative CPU share
      };
    };
      systemd.user.timers.kdrive-sync = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "10m";
        OnUnitActiveSec = "1h";
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-checkKdrive = pkgs.writeShellApplication {
      name = "custom-checkKdrive";
      runtimeInputs = with pkgs; [
        rclone
        matrix-commander-rs
        libnotify
      ];
      text = ''

        # waits for an internet connection. It pings both Google DNS  and Cloudfare dns in case one of them is down
        until ping -c1 -W1 1.1.1.1 >/dev/null 2>&1 || \
          ping -c1 -W1 8.8.8.8 >/dev/null 2>&1
        do
          sleep 1
        done

        set +e

        output=$(rclone lsd kdrive: 2>&1)
        status=$?

        set -e

        if [ $status -eq 0 ]; then
          echo "kdrive OK"
        else
          echo "kdrive rclone failed with error: $output"
          notify-send "rclone kdrive failed" "$output"
          matrix-commander-rs --verbose -m "rclone kdrive failed.<br>Error: <pre>$output</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
          --html \
          -r "\!BXRRokBmEdNOyYdfOF:matrix.org"
        fi
      '';
    };
    packages.custom-mountkdrive-laptop = pkgs.writeShellApplication {
      name = "custom-mountkdrive";
      runtimeInputs = with pkgs; [
        rclone
        libnotify
      ];
      text = ''
        REMOTE_NAME="kdrive"
        MOUNT_POINT="$HOME/kdrive"

        if rclone listremotes | rg "^''${REMOTE_NAME}:"; then
            echo "Mounting ''${REMOTE_NAME}..."
            rclone mount "''${REMOTE_NAME}:" "$MOUNT_POINT" --vfs-cache-mode writes --allow-non-empty &
        else
            notify-send "rclone mount failed" \
                "Remote ''${REMOTE_NAME} not found.\nConfigure rclone and create the dir ~/kdrive/ or comment out the exec line in hyprland.nix."
        echo        "Remote ''${REMOTE_NAME} not found. Configure rclone or comment out the exec line in hyprland.nix."
        fi
      '';
    };
    /*
    Before setting up we must:
    * setup the rclone remote
      `rclone config` choose Webdaw and see login information in bitwarden.
    * give the good permissions for the hdd
      `sudo chown -R tomasr:users /home/tomasr/hdd`
    * Run the bisync once completly
    `rclone bisync ~/hdd/kdrive/ kdrive: --resync`

    Note : only use the --resync flag once
    */
    packages.custom-synckdrive-desktop = pkgs.writeShellApplication {
      name = "custom-synckdrive";
      runtimeInputs = with pkgs; [
        rclone
        libnotify
        ripgrep
      ];
      text = ''
        REMOTE_NAME="kdrive"
        MOUNT_POINT="/home/tomasr/hdd/kdrive"
        LOGFILE="/tmp/rclone-bisync.log"
        rm LOGFILE && touch LOGFILE
        if rclone --config "$HOME/.config/rclone/rclone.conf" listremotes | rg "^''${REMOTE_NAME}:"; then
          echo "Syncing ''${REMOTE_NAME}..."
          if ! rclone --config "$HOME/.config/rclone/rclone.conf" bisync "$MOUNT_POINT" "$REMOTE_NAME:" --recover > "$LOGFILE" 2>&1; then
            notify-send "rclone bisync failed" "$(cat $LOGFILE)"
            echo "rclone bisync failed"
            cat $LOGFILE
            cp $LOGFILE "$HOME/hdd/kdrive/logs/$(date +%Y-%m-%d-%H-%M-%S).log"
          fi
        else
            notify-send "rclone sync failed" \
                "Remote ''${REMOTE_NAME} not found.\nConfigure rclone and create the dir ~/kdrive/ or comment out the exec line in hyprland.nix."
            echo        "Remote ''${REMOTE_NAME} not found. Configure rclone or fix in ~/nixos/modules/applications/kdrive.nix"
        fi
      '';
    };
  };
}
