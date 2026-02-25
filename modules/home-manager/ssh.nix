{ config, pkgs, ... }:

{

  programs.ssh = {
    enable = true;
    #agentKeys = [
    #  "/home/tomasr/.ssh/id_ed25519"
    #];
  };
  services.ssh-agent.enable = true;

}
