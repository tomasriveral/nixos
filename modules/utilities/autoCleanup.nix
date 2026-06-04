{self, ...}: {
  flake.nixosModules.autoCleanup-laptop = {
    pkgs,
    pkgs-unstable,
    ...
  }: {
    # Ensure your script is available system-wide
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-cleanNix-laptop
      pkgs-unstable.statix
    ];
    users.users.tomasr = {
      linger = true; # lingering is required
    };

    systemd.user.services.custom-cleanNix = {
      description = "NixOS configuration auto cleanup";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "/run/current-system/sw/bin/custom-cleanNix";

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
    systemd.user.timers.custom-cleanNix = {
      wantedBy = ["timers.target"];

      timerConfig = {
        OnCalendar = "Sat *-*-* 20:00:00"; # runs saturday night. If for whatever reason something breaks. I have whole sunday to fix it.

        Persistent = true; # if it happens during shutted down

        # avoids thundering herd on boot
        RandomizedDelaySec = "2h";
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-cleanNix-laptop = pkgs.writeShellApplication {
      name = "custom-cleanNix";

      runtimeInputs = with pkgs; [
        git
        nixos-rebuild
        matrix-commander-rs
        libnotify
        alejandra
        deadnix
      ];

      text = ''
        set -e

        FLAKE_DIR="/home/tomasr/nixos"
        FLAKE="$FLAKE_DIR#laptop"
        TIME=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

        ERROR_FILE=$(mktemp)

        # snapshot current state
        git -C "$FLAKE_DIR" add -A
        git -C "$FLAKE_DIR" commit --allow-empty -m "snapshot pre-cleanup-$TIME"
        git -C "$FLAKE_DIR" tag "pre-cleanup-$TIME" HEAD

        # the echos are to separate what each one is doing. Just for curiosity
        echo "deadnix scans your Nix code and removes or reports unused (dead) variables and bindings"
        deadnix --edit "$FLAKE_DIR" # removes unused code
        echo "--------------------------------------------------------------"
        echo "statix lints your Nix code to find stylistic issues, bad patterns, and potential mistakes."
        statix fix "$FLAKE_DIR" # check other linting issues
        echo "--------------------------------------------------------------"
        echo "alejandra formats your Nix code consistently according to a strict, opinionated style."
        alejandra "$FLAKE_DIR" # formats the config
        echo "--------------------------------------------------------------"

        if sudo /run/current-system/sw/bin/nixos-rebuild switch --flake "$FLAKE" 2> "$ERROR_FILE"; then # use /run/.../bin/ uses the sudoless rule

          if ! git -C "$FLAKE_DIR" diff --quiet HEAD; then
            git -C "$FLAKE_DIR" add -A
            git -C "$FLAKE_DIR" commit -m "Auto: cleanup-$TIME"
            git -C "$FLAKE_DIR" push

            notify-send "Nix auto cleanup" "Everything OK"

            matrix-commander-rs --verbose -m "Nix auto cleanup. Everything OK.<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
              --html \
              -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
            else
              notify-send "Nix auto cleanup" "No changes"
              git -C "$FLAKE_DIR" push
            fi

        else
          ERROR_MSG=$(cat "$ERROR_FILE")

          notify-send -u critical "Nix auto cleanup" "FAILED"

          matrix-commander-rs --verbose -m "Nix auto cleanup failed.<br>Error: <pre>$ERROR_MSG</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
            --html \
            -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"

          git -C "$FLAKE_DIR" reset --hard "pre-cleanup-$TIME"
        fi
        git -C "$FLAKE_DIR" tag -d "pre-cleanup-$TIME" # removes the tag

        rm -f "$ERROR_FILE"
      '';
    };
  };

  ## Desktop
  flake.nixosModules.autoCleanup-desktop = {
    pkgs,
    pkgs-unstable,
    ...
  }: {
    # Ensure your script is available system-wide
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-cleanNix-desktop
      pkgs-unstable.statix
    ];
    users.users.tomasr = {
      linger = true; # lingering is required
    };

    systemd.user.services.custom-cleanNix = {
      description = "NixOS configuration auto cleanup";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "/run/current-system/sw/bin/custom-cleanNix";

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
    systemd.user.timers.custom-cleanNix = {
      wantedBy = ["timers.target"];

      timerConfig = {
        OnCalendar = "Sat *-*-* 20:00:00"; # runs saturday night. If for whatever reason something breaks. I have whole sunday to fix it.

        Persistent = true; # if it happens during shutted down

        # avoids thundering herd on boot
        RandomizedDelaySec = "2h";
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.custom-cleanNix-desktop = pkgs.writeShellApplication {
      name = "custom-cleanNix";

      runtimeInputs = with pkgs; [
        git
        nixos-rebuild
        matrix-commander-rs
        libnotify
        alejandra
        deadnix
      ];

      text = ''
        set -e

        FLAKE_DIR="/home/tomasr/nixos"
        FLAKE="$FLAKE_DIR#desktop"
        TIME=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

        ERROR_FILE=$(mktemp)

        # snapshot current state
        git -C "$FLAKE_DIR" add -A
        git -C "$FLAKE_DIR" commit --allow-empty -m "snapshot pre-cleanup-$TIME"
        git -C "$FLAKE_DIR" tag "pre-cleanup-$TIME" HEAD

        # the echos are to separate what each one is doing. Just for curiosity
        echo "deadnix scans your Nix code and removes or reports unused (dead) variables and bindings"
        deadnix --edit "$FLAKE_DIR" # removes unused code
        echo "--------------------------------------------------------------"
        echo "statix lints your Nix code to find stylistic issues, bad patterns, and potential mistakes."
        statix fix "$FLAKE_DIR" # check other linting issues
        echo "--------------------------------------------------------------"
        echo "alejandra formats your Nix code consistently according to a strict, opinionated style."
        alejandra "$FLAKE_DIR" # formats the config
        echo "--------------------------------------------------------------"

        if sudo /run/current-system/sw/bin/nixos-rebuild switch --flake "$FLAKE" 2> "$ERROR_FILE"; then # use /run/.../bin/ uses the sudoless rule

          if ! git -C "$FLAKE_DIR" diff --quiet HEAD; then
            git -C "$FLAKE_DIR" add -A
            git -C "$FLAKE_DIR" commit -m "Auto: cleanup-$TIME"
            git -C "$FLAKE_DIR" push

            notify-send "Nix auto cleanup" "Everything OK"

            matrix-commander-rs --verbose -m "Nix auto cleanup. Everything OK.<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
              --html \
              -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
            else
              notify-send "Nix auto cleanup" "No changes"
              git -C "$FLAKE_DIR" push
            fi

        else
          ERROR_MSG=$(cat "$ERROR_FILE")

          notify-send -u critical "Nix auto cleanup" "FAILED"

          matrix-commander-rs --verbose -m "Nix auto cleanup failed.<br>Error: <pre>$ERROR_MSG</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
            --html \
            -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"

          git -C "$FLAKE_DIR" reset --hard "pre-cleanup-$TIME"
        fi
        git -C "$FLAKE_DIR" tag -d "pre-cleanup-$TIME" # removes the tag

        rm -f "$ERROR_FILE"
      '';
    };
  };
}
