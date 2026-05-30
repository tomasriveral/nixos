{self, ...}: let
  cacheTime = "10";
in {
  flake.nixosModules.documentation = {pkgs, ...}: {
    # unfortunatly this adds a lot of computation when nix rebuilds
    documentation.man.cache.enable = true; # used for the man script

    environment.pathsToLink = [
      # see https://wiki.nixos.org/wiki/Documentation_Gaps#How_do_manpages_work?_Or:_environment.pathsToLink_and_buildEnv
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    environment.systemPackages = [
      pkgs.manix
      self.packages.${pkgs.system}.custom-man
      self.packages.${pkgs.system}.custom-manix
    ];
  };
  perSystem = {pkgs, ...}: {
    packages.custom-man = pkgs.writeShellApplication {
      name = "custom-man";
      runtimeInputs = with pkgs; [
        man
        ripgrep
        fzf
      ];
      text = ''
        CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}"
        CACHE_FILE="$CACHE_DIR/custom-man-options.txt"
        mkdir -p "$CACHE_DIR"

        REGENERATE=0

        # check if -r flag was passed
        if [ "''${1:-}" = "-r" ]; then
          REGENERATE=1
        fi


        # regenerate if file does not exist or is older than cacheTime days
        if [ ! -f "$CACHE_FILE" ] || [ "$(find "$CACHE_FILE" -mtime +${cacheTime} -print)" ]; then
          REGENERATE=1
        fi

        if [ $REGENERATE -eq 1 ]; then
          echo "(Re)building custom-manix cache..."
          mkdir -p "$(dirname "$CACHE_FILE")"
              man -k . > "$CACHE_FILE"
        fi

        # read from cache and pipe into fzf
        cat "$CACHE_FILE" \
          | fzf --preview "man {1}" \
          | xargs man
      '';
    };
    packages.custom-manix = pkgs.writeShellApplication {
      name = "custom-manix";
      runtimeInputs = with pkgs; [
        manix
        ripgrep
        fzf
      ];
      text = ''
        CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}"
        CACHE_FILE="$CACHE_DIR/custom-manix-options.txt"
        mkdir -p "$CACHE_DIR"

        REGENERATE=0

        # check if -r flag was passed
        if [ "''${1:-}" = "-r" ]; then
          REGENERATE=1
        fi


        # regenerate if file does not exist or is older than cacheTime days
        if [ ! -f "$CACHE_FILE" ] || [ "$(find "$CACHE_FILE" -mtime +${cacheTime} -print)" ]; then
          REGENERATE=1
        fi

        if [ $REGENERATE -eq 1 ]; then
          echo "(Re)building custom-manix cache..."
          mkdir -p "$(dirname "$CACHE_FILE")"
              manix "" | rg -N '^(?:\x1b\[[0-9;]*m)*# ' | sed 's/\x1b\[[0-9;]*m//g; s/^# //' | rg -Nv '^(<|.*https?://)' > "$CACHE_FILE"
        fi

        # read from cache and pipe into fzf
        cat "$CACHE_FILE" \
          | fzf --preview "manix {}" \
          | xargs manix
      '';
    };
  };
}
