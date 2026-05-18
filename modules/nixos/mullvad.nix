# see also ../home-manager/mullvad.nix
{pkgs-unstable, ...}: {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs-unstable.mullvad-vpn;
  };
}
