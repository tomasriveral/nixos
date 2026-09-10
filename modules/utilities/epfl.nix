{self, ...}: {
  flake.nixosModules.epfl = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      openconnect
      self.packages.${pkgs.system}.custom-mountEpflDrive
    ];
  };

  flake.nixosModules.cs-119l = {pkgs, ...}: 
  let
    user = "YOUR_USERNAME";
    home = "/home/${user}";
    src = "${home}/epfl/cs-119l-ICC/";
    dst = "${home}/kdrive/Travaille/2 - Bachelor/Information, calcul, communication CS-119l/";
  in
  {
    environment.systemPackages = with pkgs; [
      vscode-fhs
    ];
    systemd.services.sync-cs119l-to-kdrive = {
      description = "Sync CS-119l ICC to kDrive";
  
      serviceConfig = {
        Type = "oneshot";
        User = user;
  
        ExecStart =
          "${pkgs.rsync}/bin/rsync -a '${src}' '${dst}'";
      };
    };
  
    systemd.timers.sync-cs119l-to-kdrive = {
      description = "Sync CS-119l ICC to kDrive every Thursday and Friday evening";
  
      wantedBy = [ "timers.target" ];
  
      timerConfig = {
        OnCalendar = [
          "Thu *-*-* 20:00:00"
          "Fri *-*-* 20:00:00"
        ];
        Persistent = true;
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-mountEpflDrive = pkgs.writeShellApplication {
      name = "custom-mountEpflDrive";
      runtimeInputs = with pkgs; [
        rclone
        libnotify
      ];
      text = ''
        REMOTE_NAME="epfl"
        MOUNT_POINT="$HOME/epfl/drive"

        if rclone listremotes | rg "^''${REMOTE_NAME}:"; then
            echo "Mounting ''${REMOTE_NAME}..."
            rclone mount "''${REMOTE_NAME}:" "$MOUNT_POINT" --vfs-cache-mode writes --allow-non-empty &
        else
            notify-send "rclone mount failed" \
                "Remote ''${REMOTE_NAME} not found.\nConfigure rclone and create the dir ~/epfl/drive/ or comment out the exec line in hyprland.lua."
        echo        "Remote ''${REMOTE_NAME} not found. Configure rclone or comment out the exec line in hyprland.lua."
        fi
      '';
    };
  };

}
