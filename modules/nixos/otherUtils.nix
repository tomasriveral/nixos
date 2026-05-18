# try to keep packages here at a minium. Preferably use a dedicated file
{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-calculator
    snapshot
    gnome-characters
    #tree # shows dir in tree # we use eza now
    brightnessctl # control brightness
    powertop
    fzf
    bottom # Cross-platform graphical process/system monitor with a customizable interface
    tomato-c # pomodoro timer
    #hyprshot
    mailcap
    fuzzel
    usbutils # used for lsusb
    (pkgs.callPackage ../../modules/scripts/dontkillsteam.nix {}) # kill app (if it is steam put it in some background
    (pkgs.callPackage ../../modules/scripts/killall.nix {}) # kill all windows except focused window
    (pkgs.callPackage ../../modules/scripts/tomato.nix {})
    (pkgs.callPackage ../../modules/scripts/syllabes.nix {}) # python script to get number of syllabes in french
    pkgs-unstable.bitwarden-desktop
    fluffychat # matrix client
  ];
}
