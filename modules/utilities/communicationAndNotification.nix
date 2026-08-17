{self, ...}: {
  flake.nixosModules.notifications = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libnotify # Library that sends desktop notifications to a notification daemon
      socat # Utility for bidirectional data transfer between two independent data channels (used to communicate between hyprland and awww to change wallpapers dinamically)
      # battery notifications
      /*self.packages.${pkgs.system}.custom-batterynotify
      self.packages.${pkgs.system}.custom-batterywarning*/
      self.packages.${pkgs.system}.custom-gitnotify # checks if git is set up
      self.packages.${pkgs.system}.custom-checkKdrive # check if kdrive is set up with rclone
      zoom-us
    ];
  };
  perSystem = {pkgs, ...}: {
    packages.custom-gitnotify = pkgs.writeShellApplication {
      name = "custom-gitnotify";
      runtimeInputs = with pkgs; [
        git
        libnotify
        curl
      ];
      text = ''
        # shellcheck disable=SC1091
        source /run/agenix/ntfy

        # Check if git is installed
        if ! command -v git >/dev/null 2>&1; then
            exit 0
        fi

        NAME=$(git config --global user.name)
        EMAIL=$(git config --global user.email)

        if [[ -z "$NAME" || -z "$EMAIL" ]]; then
            notify-send \
                "Git not configured" \
                "Set your identity\n or remove this warning by removing the custom-gitnotify line in\n ~/nixos/modules/applications/hyprland.nix"
            curl \
              -u ":$NTFY_TOKEN" \
              -d "Git not configured" \
              "$NTFY_SERVER/Alerts"
        fi
      '';
    };
  };
}
