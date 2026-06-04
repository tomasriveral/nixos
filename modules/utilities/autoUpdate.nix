{self, ...}: {
  flake.nixosModules.autoUpdate-laptop = {pkgs, ...}: {
    # Ensure your script is available system-wide
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-autoupdate-laptop
    ];
    users.users.tomasr = {
      linger = true; # lingering is required
    };

    systemd.user.services.custom-autoupdate = {
      description = "NixOS flake auto update";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "/run/current-system/sw/bin/custom-autoupdate";

        # safety for long rebuilds
        TimeoutStartSec = "45min";
        TimeoutStopSec = "10min";

        # avoid overlap
        RemainAfterExit = true;

        # tweaks that should make the system run normally during the rebuilds
        Nice = 10;
        IOSchedulingClass = "best-effort";
        IOSchedulingPriority = 7;
      };
    };

    # Systemd USER timer
    systemd.user.timers.custom-autoupdate = {
      wantedBy = ["timers.target"];

      timerConfig = {
        OnCalendar = "Fri *-*-* 20:00:00"; # runs friday night. If for whatever reason something breaks. I have whole week-end to fix it.

        Persistent = true; # if it happens during shutted down

        # avoids thundering herd on boot
        RandomizedDelaySec = "2h";
      };
    };
  };

  ## desktop
  flake.nixosModules.autoUpdate-desktop = {pkgs, ...}: {
    # Ensure your script is available system-wide
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-autoupdate-desktop
    ];
    users.users.tomasr = {
      linger = true; # lingering is required
    };

    systemd.user.services.custom-autoupdate = {
      description = "NixOS flake auto update";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "/run/current-system/sw/bin/custom-autoupdate";

        # safety for long rebuilds
        TimeoutStartSec = "45min";
        TimeoutStopSec = "10min";

        # avoid overlap
        RemainAfterExit = true;

        # tweaks that should make the system run normally during the rebuilds
        Nice = 10;
        IOSchedulingClass = "best-effort";
        IOSchedulingPriority = 7;
      };
    };

    # Systemd USER timer
    systemd.user.timers.custom-autoupdate = {
      wantedBy = ["timers.target"];

      timerConfig = {
        OnCalendar = "Fri *-*-* 20:00:00"; # runs friday night. If for whatever reason something breaks. I have whole week-end to fix it.

        Persistent = true; # if it happens during shutted down

        # avoids thundering herd on boot
        RandomizedDelaySec = "2h";
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-autoupdate-laptop = pkgs.writeShellApplication {
      name = "custom-autoupdate";

      runtimeInputs = with pkgs; [
        git
        nixos-rebuild
        matrix-commander-rs
        libnotify
      ];

      text = ''
        set -e

        FLAKE_DIR="/home/tomasr/nixos"
        FLAKE="$FLAKE_DIR#laptop"
        TIME=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

        ERROR_FILE=$(mktemp)

        # snapshot current state
        git -C "$FLAKE_DIR" add -A
        git -C "$FLAKE_DIR" commit --allow-empty -m "snapshot pre-autoupdate-$TIME"
        git -C "$FLAKE_DIR" tag "pre-autoupdate-$TIME" HEAD

        # update lock only
        nix flake update --flake "$FLAKE_DIR"

        if sudo /run/current-system/sw/bin/nixos-rebuild switch --flake "$FLAKE" 2> "$ERROR_FILE"; then # use /run/.../bin/ uses the sudoless rule

          if ! git -C "$FLAKE_DIR" diff --quiet -- flake.lock; then
            git -C "$FLAKE_DIR" add flake.lock
            git -C "$FLAKE_DIR" commit -m "flake.lock: autoupdate-$TIME"
            git -C "$FLAKE_DIR" push

            notify-send "Flake autoupdate" "Rebuild OK"

            matrix-commander-rs --verbose -m "Flake rebuild succesfull.<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
              --html \
              -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
            else
              notify-send "Flake autoupdate" "No changes"
              git -C "$FLAKE_DIR" push
            fi

        else
          ERROR_MSG=$(cat "$ERROR_FILE")

          notify-send -u critical "Flake autoupdate" "FAILED"

          matrix-commander-rs --verbose -m "Flake rebuild failed.<br>Error: <pre>$ERROR_MSG</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
            --html \
            -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"

          git -C "$FLAKE_DIR" reset --hard "pre-autoupdate-$TIME"
        fi

        git -C "$FLAKE_DIR" tag -d "pre-autoupdate-$TIME" # removes the tag

        rm -f "$ERROR_FILE"
      '';
    };
    packages.custom-autoupdate-desktop = pkgs.writeShellApplication {
      name = "custom-autoupdate";

      runtimeInputs = with pkgs; [
        git
        nixos-rebuild
        matrix-commander-rs
        libnotify
      ];

      text = ''
        set -e

        FLAKE_DIR="/home/tomasr/nixos"
        FLAKE="$FLAKE_DIR#desktop"
        TIME=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

        ERROR_FILE=$(mktemp)

        # snapshot current state
        git -C "$FLAKE_DIR" add -A
        git -C "$FLAKE_DIR" commit --allow-empty -m "snapshot pre-autoupdate-$TIME"
        git -C "$FLAKE_DIR" tag "pre-autoupdate-$TIME" HEAD

        # update lock only
        nix flake update --flake "$FLAKE_DIR"

        if sudo /run/current-system/sw/bin/nixos-rebuild switch --flake "$FLAKE" 2> "$ERROR_FILE"; then # use /run/.../bin/ uses the sudoless rule

          if ! git -C "$FLAKE_DIR" diff --quiet -- flake.lock; then
            git -C "$FLAKE_DIR" add flake.lock
            git -C "$FLAKE_DIR" commit -m "flake.lock: autoupdate-$TIME"
            git -C "$FLAKE_DIR" push

            notify-send "Flake autoupdate" "Rebuild OK"

            matrix-commander-rs --verbose -m "Flake rebuild succesfull.<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
              --html \
              -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
            else
              notify-send "Flake autoupdate" "No changes"
              git -C "$FLAKE_DIR" push
            fi

        else
          ERROR_MSG=$(cat "$ERROR_FILE")

          notify-send -u critical "Flake autoupdate" "FAILED"

          matrix-commander-rs --verbose -m "Flake rebuild failed.<br>Error: <pre>$ERROR_MSG</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
            --html \
            -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"

          git -C "$FLAKE_DIR" reset --hard "pre-autoupdate-$TIME"
        fi

        git -C "$FLAKE_DIR" tag -d "pre-autoupdate-$TIME" # removes the tag

        rm -f "$ERROR_FILE"
      '';
    };
  };
}
