{ ... }: {
  flake.homeModules.thunderbird = { ... }: {
    programs.thunderbird = {
      enable = true;
      profiles.tomasr = {
        isDefault = true;
      };
    };
  };
}
