_: {
  flake.nixosModules.onxyboox = _: {
      services.gvfs.enable = true;
  };
}
