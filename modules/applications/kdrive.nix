{self, ...}: {
  flake.nixosModules.kdrive = {pkgs-unstable, ...}: {
    environment.systemPackages = with pkgs-unstable; [
      rclone
      self.packages.${pkgs.system}.custom-checkKdrive
      self.packages.${pkgs.system}.custom-mountkdrive
    ];
    # removes rclone error
    programs.fuse = {
      userAllowOther = true;
      enable = true;
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
          -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
        fi
      '';
    };
    packages.custom-mountkdrive = pkgs.writeShellApplication {
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
  };
}
