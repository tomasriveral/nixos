_: {
  flake.homeModules.git = _: {
    programs.git = {
      enable = true;
      /*
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
