{self, ...}: {
  flake.nixosModules.notifications = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libnotify # Library that sends desktop notifications to a notification daemon
      socat # Utility for bidirectional data transfer between two independent data channels (used to communicate between hyprland and awww to change wallpapers dinamically)
      matrix-commander-rs # matrix client used to send notifications from scripts to my phone
      # battery notifications
      self.packages.${pkgs.system}.custom-batterynotify
      self.packages.${pkgs.system}.custom-batterywarning
      # checks if matrix-commander-rs is installed and logged in
      self.packages.${pkgs.system}.custom-checkMatrix
      self.packages.${pkgs.system}.custom-gitnotify # checks if git is set up
      self.packages.${pkgs.system}.custom-checkKdrive # check if kdrive is set up with rclone
    ];
  };
  perSystem = {pkgs, ...}: {
    packages.custom-checkMatrix = pkgs.writeShellApplication {
      name = "custom-checkMatrix";

      runtimeInputs = with pkgs; [
        matrix-commander-rs
        libnotify
      ];

      text = ''
        expected="@totorile1:unredacted.org"

        current="$(matrix-commander-rs --whoami | tr -d '\n')"

        if [ "$current" != "$expected" ]; then
          notify-send "matrix-commander-rs" \
            "You are not logged in as @totorile1:unredacted.org\nLog:\n$current"
        fi
      '';
    };
    packages.custom-gitnotify = pkgs.writeShellApplication {
      name = "custom-gitnotify";
      runtimeInputs = with pkgs; [
        git
        libnotify
      ];
      text = ''
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
            matrix-commander-rs --verbose -m "Git not configured.<br>Set your identify or remove this warning by removing the custom-gitnotify in ~/nixos/modules/applications/hyprland.nix<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
            --html \
            -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
        fi
      '';
    };
  };
}
