{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    # user.email dont work #user.email = "137088692+Totorile1@users.noreply.github.com";
    #user.name = "Totorile1";
    # no declarative parameters for git as it would show in a public git repo more info than I would like. Just use the following commands
    # git config --global user.name "YourName"
    # git config --global user.email "YourEmail"
    # git config --global init.defaultBranch main
# git config --global user.email "137088692+Totorile1@users.noreply.github.com"
#cd ~/nixos\
#git add . 
#git commit -m "Update NixOS configuration" 
#git push origin master

};
}
