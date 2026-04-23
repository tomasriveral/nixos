{
  config,
  pkgs,
  ...
}: {
  # gtk config
  gtk.theme = {
    enable = true;
    Gruvbox-GTK-Theme-BL-MB = {
      enable = true;
      name = "Gruvbox-GTK-Theme-BL-MB";
      package = pkgs.gruvbox-gtk-theme;
    };
  };
  # to resolve this https://wiki.nixos.org/wiki/Home_Manager#I_cannot_set_GNOME_or_Gtk_themes_via_Home_Manager
}
