_: {
  flake.nixosModules.office = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libreoffice
      birdtray
      kdePackages.korganizer
      #needed for korganizer
      kdePackages.akonadi
      kdePackages.akonadi-calendar
      kdePackages.akonadi-calendar-tools
    ];
    programs.kde-pim.kontact = true; # needed for korganizer
  };
}
