{ inputs, ...}: {
  flake.nixosModule.bluetooth = {pkgs, ...}: {
    hardware.bluetooth.enable = true;
    environment.systemPackages = with pkgs; [
      blueman # GTK-based Bluetooth Manager
    ];
  };
}
