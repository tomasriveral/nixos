# most of the themeing are in the home-manager modules. This just installs some packages needed
{pkgs, ...}: {
  qt.enable = true;

  # to resolve this https://wiki.nixos.org/wiki/Home_Manager#I_cannot_set_GNOME_or_Gtk_themes_via_Home_Manager
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    swww #wallpaper daemon
    gruvbox-gtk-theme
    hyprcursor
    capitaine-cursors-themed # cursor theme
    kdePackages.qtdeclarative # provides qmlls and other things
    quickshell # we have it but adding it there solves "WARN qt.qpa.services: Failed to register with host portal QDBusError("org.freedesktop.portal.Error.Failed", "Could not register app ID: App info not found for 'org.quickshell'")"
    papirus-icon-theme
    papirus-folders
    (pkgs.callPackage ../../modules/scripts/wallpaper.nix {})
    #(pkgs.callPackage ../../modules/scripts/colorpicker.nix {}) # old color picker
    #(pkgs.callPackage ../../modules/scripts/weather.nix {}) # old cli weather
    (pkgs.callPackage ../../hostsModules/laptop/qt/qtbatticon.nix {}) # custom qt tray icon for battery
  ];
}
