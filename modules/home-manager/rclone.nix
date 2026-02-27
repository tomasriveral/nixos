{ config, pkgs, agenix, ... }:

{
  programs.rclone = {
    enable = true;
  };
}
