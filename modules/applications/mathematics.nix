_: {
  flake.nixosModules.mathematics = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      elan
    ];
  };
}
