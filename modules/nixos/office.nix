{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libreoffice
    birdtray
  ];
}
