# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  libs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../hostsModules/laptop/nixos/battery.nix
    #../../modules/nixos/ly.nix
    ../../modules/nixos/ly.nix
    ../../modules/nixos/anki.nix
    ../../modules/nixos/nixUtils.nix ../../hostsModules/laptop/nixos/nixUtils.nix
    ../../hostsModules/laptop/nixos/udev.nix
    ../../hostsModules/laptop/nixos/disk.nix
    ../../modules/nixos/printer.nix
    ../../hostsModules/laptop/nixos/ollama.nix # llm config
    ../../modules/nixos/mullvad.nix # vpn config
    ../../hostsModules/laptop/nixos/autoUpdate.nix # auto update the flakes. Handles notification via libnotify and matrix-commander-rs
    ../../hostsModules/laptop/nixos/bootloader.nix
    ../../hostsModules/laptop/nixos/networking.nix # firewall, ssh, networkmanager, etc.
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/audioAndMedia.nix
    ../../modules/nixos/windowManager.nix
    ../../modules/nixos/documentation.nix
    ../../modules/nixos/IO.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/latex.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/user.nix ../../hostsModules/laptop/nixos/user.nix
    ../../modules/nixos/notifications.nix
    ../../modules/nixos/browser.nix
    ../../modules/nixos/theme.nix # install theming packages and some quickshell stuff
  ];

  # removes rclone error
  programs.fuse.userAllowOther =  true;
  programs.fuse.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; # Nonfree packages: hplipWithPlugin

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # use pkgs-unstable if you want the package from the unstable channel
    #we need to install gnome and kde utils individually as we dont use gnome
    gnome-calculator
    snapshot
    gnome-characters
    gnome-disk-utility
    #tree # shows dir in tree # we use eza now
    brightnessctl # control brightness
    udiskie # removable disk automounter for udisks
    cowsay
    cmatrix
    libreoffice
    powertop
    fzf
    bottom # Cross-platform graphical process/system monitor with a customizable interface
    cmatrix
    tomato-c # pomodoro timer
    #hyprshot
    mailcap
    pkgs-unstable.vimPluginsUpdater # used for building plugins
    vial # Open-source GUI and QMK fork for configuring your keyboard in real time
    usbutils # used for lsusb
    # used for the framework 16 laptop
    framework-tool
    framework-tool-tui
    fluffychat # matrix client
    fuzzel
    birdtray # thunderbird tray app
    # this is more up to date
    #(callPackage ../../modules/packages/vivify.nix {})
    #(callPackage ../../modules/packages/sbb-tui.nix {})
    pkgs-unstable.bitwarden-desktop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # to resolve this https://wiki.nixos.org/wiki/Home_Manager#I_cannot_set_GNOME_or_Gtk_themes_via_Home_Manager
  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
