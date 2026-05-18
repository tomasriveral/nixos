{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnome-disk-utility
    udiskie # removable disk automounter for udisks
    (pkgs.callPackage ../../modules/scripts/mountkdrive.nix {})
  ];

  # removes rclone error
  programs.fuse.userAllowOther = true;
  programs.fuse.enable = true;
}
