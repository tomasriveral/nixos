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

    # acording to https://community.frame.work/t/solved-keys-stick-and-repeat-after-being-released/51153/12
    # the random keypress stuck comes from conflict between powertop and udev
    # fix from: https://git.gabbie.blue/blue/nixconf/src/commit/2d1bc6dad4684c019b6b3e894408e76e2734806c/hosts/gabbielaptop/configuration.nix#L68
    # disable USB auto suspend for framework keyboard
    ACTION=="bind", SUBSYSTEM=="usb", ATTR{idVendor}=="32ac", ATTR{idProduct}=="0018", TEST=="power/control", ATTR{power/control}="on"
    # disable USB auto suspend for framework macropad
    ACTION=="bind", SUBSYSTEM=="usb", ATTR{idVendor}=="32ac", ATTR{idProduct}=="0013", TEST=="power/control", ATTR{power/control}="on"
  '';
}
