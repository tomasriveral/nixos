_: {
  flake.nixosModules.hardwareUtils-laptop = {pkgs-unstable, ...}: {
    environment.systemPackages = with pkgs-unstable; [
      # used for the framework 16 laptop
      framework-tool
      framework-tool-tui
      vial # Open-source GUI and QMK fork for configuring your keyboard in real time
      netwatch
      (diskwatch.override {
        withSmartmontools = true;
      })
      syswatch
    ];
  };
  flake.nixosModules.hardwareUtils-desktop = {pkgs-unstable, ...}: {
    environment.systemPackages = with pkgs-unstable; [
      netwatch
      (diskwatch.override {
        withSmartmontools = true;
      })
      syswatch
    ];
  };
}
