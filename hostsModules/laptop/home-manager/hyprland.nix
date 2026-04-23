{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "qtbatticon" # custom battery tray
    ];
    monitor = [
      "eDP-1, highres@highrr, 0x0, 1"
    ];
  };
}
