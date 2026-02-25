{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    # no declarative parameters for git as it would show in a public git repo more info than I would like. Just use the following commands
    # git config --global user.name "YourName"
    # git config --global user.email "YourEmail"
    # git config --global init.defaultBranch main

#cd ~/nixos\
#git add . 
#git commit -m "Update NixOS configuration" 
#git push origin master

};
}
