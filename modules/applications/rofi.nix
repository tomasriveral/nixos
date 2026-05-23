{ ... }: {
  flake.homeModules.rofi = { ... }: {
    programs.rofi = {
      enable = true;
      theme = "gruvbox-dark-hard";
    };
  };
}
