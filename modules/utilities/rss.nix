_: {
  flake.nixosModules.rss = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nom
    ];
  };
}
