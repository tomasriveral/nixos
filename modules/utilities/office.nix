_: {
  flake.nixosModules.office = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libreoffice
      birdtray
    ];
  };
}
