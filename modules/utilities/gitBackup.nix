{self, ...}: {
  flake.nixosModules.gitBackup = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-gitBackup
    ];

    systemd.user.services.custom-gitBackup = {
      description = "Backup selected git repos";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "/run/current-system/sw/bin/custom-gitBackup";

        TimeoutStartSec = "45min";
        TimeoutStopSec = "10min";

        RemainAfterExit = true;

        Nice = 10;
        IOSchedulingClass = "best-effort";
        IOSchedulingPriority = 7;
      };
    };

    # Systemd USER timer
    systemd.user.timers.custom-gitBackup = {
      wantedBy = ["timers.target"];

      timerConfig = {
        OnCalendar = "Thu *-*-* 12:00:00";

        Persistent = true; # if it happens during shutted down

        RandomizedDelaySec = "20min";
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-gitBackup = pkgs.writeShellApplication {
      name = "custom-gitBackup";
      runtimeInputs = with pkgs; [
        rsync
        matrix-commander-rs
        libnotify
        self.packages.${pkgs.system}.custom-checkKdrive
      ];
      text = ''
        # checks if kdrive is available
        custom-checkKdrive

        REPOS=(
            "https://github.com/tomasriveral/nixos.git"
            "https://github.com/tomasriveral/notewrapper.git"
            "https://github.com/tomasriveral/fractal-cli.git"
            "https://github.com/tomasriveral/boids.git"
            "https://github.com/tomasriveral/nixpkgs-notifier.git"
            "https://github.com/tomasriveral/Nix-Git-Cherry-Picker.git"
            "https://github.com/tomasriveral/ReSSPublica.git"
        )

        LOCAL_BACKUP_DIR="$HOME/.gitBackups"
        CLOUD_DIR="$HOME/kdrive/Code/gitBackups"

        # Create backup directories if they don't exist
        mkdir -p "$LOCAL_BACKUP_DIR"
        mkdir -p "$CLOUD_DIR"

        notify_error() {
            local message="$1"
            notify-send "Git Backup Failed" "$message"
            matrix-commander-rs --verbose -m "Git Backup Failed: $message <br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
            --html \
            -r "\!BXRRokBmEdNOyYdfOF:matrix.org"

        }

        for REPO in "''${REPOS[@]}"; do
            # Extract repo name (without .git)
            REPO_NAME=$(basename "$REPO" .git)
            LOCAL_REPO_PATH="$LOCAL_BACKUP_DIR/$REPO_NAME.git"

            if [ ! -d "$LOCAL_REPO_PATH" ]; then
                # Clone mirror if it doesn't exist
                echo "Cloning $REPO..."
                git clone --mirror "$REPO" "$LOCAL_REPO_PATH" || { notify_error "Failed to clone $REPO"; continue; }
            else
                # Update existing mirror
                echo "Updating $REPO..."
                cd "$LOCAL_REPO_PATH" || { notify_error "Cannot enter $LOCAL_REPO_PATH"; continue; }
                git remote update || { notify_error "Failed to update $REPO"; continue; }
            fi

            # Rsync to cloud directory (only changes, preserve permissions)
            echo "Syncing $REPO_NAME to cloud..."
            rsync -a --delete "$LOCAL_REPO_PATH/" "$CLOUD_DIR/$REPO_NAME/" || { notify_error "Failed to rsync $REPO_NAME"; continue; }

        done

        echo "All backups completed."
      '';
    };
  };
}
