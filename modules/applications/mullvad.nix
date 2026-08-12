_: {
  flake.nixosModules.mullvad = _: {
    services.mullvad-vpn = {
      enable = true;
    };
  };
  flake.homeModules.mullvad = _: {
    programs.mullvad-vpn = {
      # gui
      enable = true;
    };
  };
}
