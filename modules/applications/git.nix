_: {
  flake.homeModules.git = _: {
    programs.git = {
      enable = true;
      /*
        for some reason this doesnt work really well. So it's best to setup git imperatively
        push.autoSetupRemote to true
        settings = {
        init.defaultBranch = "main";
      };
      */
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
