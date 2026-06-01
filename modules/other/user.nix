_: {
  flake.nixosModules.user = {
    pkgs,
    pkgs-unstable,
    ...
  }: {
    services.dbus.enable = true;
    security.polkit.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Zurich";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # zsh dont want to work if it is not initialzed here.
    programs.zsh.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.tomasr = {
      isNormalUser = true;
      description = "Tomas Rivera";
      extraGroups = ["networkmanager" "wheel" "fuse"]; #wheel allow to use sudo / fuse -> rclone
      shell = pkgs.zsh;
    };

    services.upower.enable = true;

    # removes need for password for nixos-rebuild
    security.sudo = {
      extraRules = [
        {
          users = ["tomasr"];
          commands = [
            {
              command = "/run/current-system/sw/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
            {
              command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
            {
              command = "${pkgs-unstable.nixos-rebuild}/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
      extraConfig = ''
        Defaults pwfeedback
      '';
  };
  };
}
