{ ... }: {
  flake.homeModules.oh-my-posh = { ... }: {
    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "gruvbox";
    };
  };
}
