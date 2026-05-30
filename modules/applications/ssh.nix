_: {
  flake.homeModules.ssh = _: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false; # will be removed in the futur. Removes evaluation warning
      /*settings = {
        # equivalent to the default config
        #forwardAgent = false;
        # give errors in home-manager 26.05
        #addKeysToAgent = "no";
        #compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        #controlMaster = "no";
        #controlPath = "~/.ssh/master-%r@%n:%p";
        #controlPersist = "no";
      };*/
    };
    services.ssh-agent.enable = true;
    home.file.".ssh/config".text = ''
      Host *
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
