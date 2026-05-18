# notifications server is set by caelestia-shell. See ../home-manager/caelestia.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libnotify # Library that sends desktop notifications to a notification daemon
    socat # Utility for bidirectional data transfer between two independent data channels (used to communicate between hyprland and swww to change wallpapers dinamically)
    matrix-commander-rs # matrix client used to send notifications from scripts to my phone
    # battery notifications
    (pkgs.callPackage ../../hostsModules/laptop/scripts/batterynotify.nix {})
    (pkgs.callPackage ../../hostsModules/laptop/scripts/batterywarning.nix {})
    # checks if matrix-commander-rs is installed and logged in
    (pkgs.callPackage ../../hostsModules/laptop/scripts/checkMatrix.nix {})
    (pkgs.callPackage ../../modules/scripts/gitnotify.nix {}) # check if git is set up
    (pkgs.callPackage ../../modules/scripts/checkKdrive.nix {}) # check if kdrive is set up with rclone
  ];
}
