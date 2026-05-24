_: {
  flake.homeModules.oh-my-posh = _: {
    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "gruvbox";
    };
  };
}
