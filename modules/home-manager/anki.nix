_: {
  programs.anki = {
    # we enable system wide with nixpkgs because it offers some addon configuration. We just use this for some config
    #enable = true;
    theme = "dark";
    sync = {
      autoSync = true;
      autoSyncMediaMinutes = 10;
      syncMedia = true;
    };
  };
}
