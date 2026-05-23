{ ... }: {
  flake.nixosModules.mullvad = {pkgs-unstable, ...}: {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs-unstable.mullvad-vpn;
    };
  };
  flake.homeModules.mullvad = {pkgs-unstable, ...}: {
    programs.mullvad-vpn = {
      # gui
      enable = true;
      package = pkgs-unstable.mullvad-vpn;
    };
  };
}
