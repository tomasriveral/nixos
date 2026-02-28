{ config, pkgs, ... }:

{
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "jonathan";
    plugins = [
	"aliases"
	"alias-finder"
	"colored-man-pages"
	"colorize"
    ];
    };
}
