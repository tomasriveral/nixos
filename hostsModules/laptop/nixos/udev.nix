{
  config,
  pkgs,
  ...
}: {
  # udev with only the necessary rules. See udev.nix to get all the rules
  services.udev.extraRules = ''
    # adapted from here https://wiki.nixos.org/wiki/Keychron_M6
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="32ac", MODE="0660", GROUP="users", TAG+="uaccess"


    # taken from here
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0013", TAG+="uaccess"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0018", TAG+="uaccess"
  '';
}
