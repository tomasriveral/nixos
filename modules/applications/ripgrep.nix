{ ... }: {
  flake.homeModules.ripgrep = { ... }: {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "-S"
        "-."
        "-p"
        "-n"
      ];
    };
    programs.ripgrep-all = {
      enable = true;
    };
  };
}
