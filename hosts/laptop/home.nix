{ config, pkgs, ... }:

{
# every import imports a specific module for an app. This module contains the enabling of this app and its settings.
# So if you want to add an home-manager app create a module which enables it and configures it and import it.
imports = [
# app modules
../../modules/home-manager/kitty.nix # terminal # use absolute path with --impure flag or go back to /etc/nixos and use relative
../../modules/home-manager/zoxide.nix # better cd
../../modules/home-manager/zsh.nix # better bash
../../modules/home-manager/git.nix
../../modules/home-manager/ssh.nix
../../modules/home-manager/fastfetch.nix
../../modules/home-manager/hyprland.nix
../../modules/home-manager/wlogout.nix # logout utility
../../modules/home-manager/rofi.nix # launcher and keybindings helper
../../modules/home-manager/swaync.nix # notification daemon
../../modules/home-manager/neovim.nix # dont use nixvim. broken
../../modules/home-manager/rclone.nix 
];


#programs.nixvim = {
#	enable = true;
#	imports = [ ../../modules/nixvim/neovim.nix ];
#	package = pkgs.neovim;
#};
# Home Manager needs a bit of information about you and the paths it should

  # Required for Home Manager
  home.username = "tomasr";
  home.homeDirectory = "/home/tomasr";
  home.stateVersion = "25.11";  # match your Home Manager release

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.

# The home.packages option allows you to install Nix packages into your
# environment.
home.packages = [
#scritps
(pkgs.callPackage ../../modules/scripts/dontkillsteam.nix {})
(pkgs.callPackage ../../modules/scripts/batterynotify.nix {})
(pkgs.callPackage ../../modules/scripts/weather.nix {})
(pkgs.callPackage ../../modules/scripts/cowsay.nix {})
(pkgs.callPackage ../../modules/scripts/wallpaper.nix {})
(pkgs.callPackage ../../modules/scripts/mountkdrive.nix {})
# # Adds the 'hello' command to your environment. It prints a friendly
# # "Hello, world!" when run.
# pkgs.hello

# # It is sometimes useful to fine-tune packages, for example, by applying
# # overrides. You can do that directly here, just don't forget the
# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
# # fonts?
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
];

#ssh config

programs.ssh.enable = true;
services.ssh-agent.enable = true;

home.file.".ssh/config".text = ''
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
'';
    


# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;

# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
};


# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. These will be explicitly sourced when using a
# shell provided by Home Manager. If you don't want to manage your shell
# through Home Manager then you have to manually source 'hm-session-vars.sh'
# located at either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/tomasr/etc/profile.d/hm-session-vars.sh
#
home.sessionVariables = {
    EDITOR = "neovim";
    # Git update function
    # Prompts for commit message; defaults if empty
    GIT_UPDATE = ''
 echo 'Enter commit message: '
read msg
if [ -z "$msg" ]; then
  msg="Update NixOS configuration"
fi
git add . && git commit -m "$msg" && git push origin main   
    '';
  };


# Let Home Manager install and manage itself.
programs.home-manager.enable = true;
}
