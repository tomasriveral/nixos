_: {
  flake.homeModules.thunderbird = _: {
    programs.thunderbird = {
      enable = true;
      profiles.tomasr = {
        isDefault = true;
      };
    };
  };
}
