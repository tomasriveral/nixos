# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  # nixd says that those attributes are not used. The are used in the imported file. Do not remove.
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
    ../../modules/nixos/disk.nix ../../hostsModules/laptop/nixos/disk.nix
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
    ../../hostsModules/laptop/nixos/hardwareUtils.nix
    ../../modules/nixos/otherUtils.nix
    ../../modules/nixos/office.nix
  ];
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
