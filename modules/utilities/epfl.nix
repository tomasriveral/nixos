_: {
  flake.nixosModules.epfl = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      openconnect
    ];
  };
}
