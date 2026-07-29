_: {
  flake.nixosModules.rss = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      fluent-reader
    ];
  };
}
