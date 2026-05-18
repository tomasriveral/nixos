{pkgs-unstable, ...}: {
  programs.rclone = {
    enable = true;
    package = pkgs-unstable.rclone;
  };
}
