{self, ...}: {
  flake.nixosModules.performance-desktop = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.system}.custom-performance
    ];
  };
}
