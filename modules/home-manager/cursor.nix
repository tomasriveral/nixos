{ config, pkgs, ... }:
{
  home.pointerCursor = {
    hyprcursor.enable = true;
    enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
  };
}
