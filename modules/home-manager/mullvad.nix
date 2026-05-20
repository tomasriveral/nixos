# see also ../nixos/mullvad.nix
{pkgs-unstable,...}: {
  programs.mullvad-vpn = { # gui
    enable = true;
    package = pkgs-unstable.mullvad-vpn;
  };
}
