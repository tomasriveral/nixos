{ config, pkgs, ... }:

{
  programs.anki = {
    enable = true;
    sync = {
      autoSync = true;
      autoSyncMediaMinutes = 10;
      syncMedia = true;
    };
    addons = [
      pkgs.ankiAddons.recolor
    ];
  };
}
