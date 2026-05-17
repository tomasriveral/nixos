{
  pkgs,
  ...
}:
{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  # Configure console keymap
  console.keyMap = "fr_CH";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    hyprkeys # keybind helper
    hyprpicker
  ];
}
