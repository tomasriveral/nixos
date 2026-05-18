{pkgs, ...}: {
  documentation.man.generateCaches = true; # used for the man script

  environment.pathsToLink = [
    # see https://wiki.nixos.org/wiki/Documentation_Gaps#How_do_manpages_work?_Or:_environment.pathsToLink_and_buildEnv
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
  environment.systemPackages = [
    pkgs.manix
    (pkgs.callPackage ../../modules/scripts/manix.nix {}) # fzf manix searcher
    (pkgs.callPackage ../../modules/scripts/man.nix {}) # fzf man searcher
  ];
}
