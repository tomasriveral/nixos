{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  services.dbus.enable = true;
  security.polkit.enable = true;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # the home manager config is set in ../../hostsModules/*/nixos/user.nix
    extraSpecialArgs = {inherit inputs pkgs-unstable;};
  };

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

  security.wrappers.gsr-kms-server = {
    # to remove the password prompt when using gpu-screen-recorder
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
  };

  services.upower.enable = true;

  # removes need for password for nixos-rebuild
  security.sudo.extraRules = [
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
}
