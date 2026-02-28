{ config, pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "gruvbox";
    };
}
