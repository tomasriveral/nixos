_: {
  flake.nixosModules.onxyboox = {pkgs, ...}: {
    services.gvfs.enable = true;
    environment.systemPackages = with pkgs; [
      gvfs
      calibre
      kdePackages.kio-extras
    ];
  };
}
