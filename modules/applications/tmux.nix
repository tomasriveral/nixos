_: {

  flake.homeModules.tmux = _: {
    programs.tmux = {
      enable = true;
      clock24 = true;
    };
  };
}
