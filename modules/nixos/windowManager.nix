# customization is in ../home-manager/hyprland.nix
{
  pkgs-unstable,
  pkgs,
  ...
}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #  services.displayManager.gdm.enable = true;
  #  services.desktopManager.gnome.enable = true;
  # we dont use gnome but some utils yes -> see pckgs
  #enable sddm
  #services.displayManager.sddm = {
  #	enable = true;
  #	wayland.enable = true;
  #};
  # we use ly as the displayManager. see ../../modules/nixos/ly.nix

  # enable hyprland WM
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland; # we use the unstable branch to get the latest features
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  # removes uxterm
  services.xserver.excludePackages = [pkgs.xterm];

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];
}
