# configuration for main browser is in ../home-manager/librewolf.nix
# configuration for qutebrowser is in ../home-manager/vivify.nix
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    chromium # used only to flash the firmware on my framework laptop 16 (keyboard.frame.work) as only chromium based browser support webHID.
    pkgs-unstable.tor-browser
    (pkgs.callPackage ../../modules/scripts/librewolfprofiles.nix {}) # fzf librewolf profile selector
  ];
}
