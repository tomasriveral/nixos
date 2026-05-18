{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # used for the framework 16 laptop
    framework-tool
    framework-tool-tui
    vial # Open-source GUI and QMK fork for configuring your keyboard in real time
  ];
}
