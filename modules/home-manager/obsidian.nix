{ config, pkgs, ... }:

{
  programs.obsidian = {
    enable = true;

    vaults = {
      miscellanious = { enable = true; target = "/Documents/Notes/miscellanious"; };
      work          = { enable = true; target = "/Documents/Notes/work"; };
    };

    defaultSettings = {
      appearance.theme = "gruvbox";

      extraFiles = {
        ".obsidian/themes/gruvbox/manifest.json" = ../../other/obsidian-theme/manifest.json;
        ".obsidian/themes/gruvbox/obsidian.css"  = ../../other/obsidian-theme/obsidian.css;
        ".obsidian/themes/gruvbox/theme.css"     = ../../other/obsidian-theme/theme.css;
      };
    };
  };
}
