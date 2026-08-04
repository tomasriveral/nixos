_: {
  flake.nixosModules.office = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libreoffice
      birdtray
      kdePackages.korganizer
    ];
    programs.kde-pim.kontact = true; # needed for korganizer
  };
}
