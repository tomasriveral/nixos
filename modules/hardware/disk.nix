_: {
  flake.nixosModules.disk = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gnome-disk-utility
      udiskie
    ];
  };
  flake.nixosModules.disk-laptop = _: {
    # i found swap necessary when running nixpkgs review
    swapDevices = [
      {
        device = "/swapfile";
        size = 16384; # 16 GB
      }
    ];
    boot.kernel.sysctl."vm.swappiness" = 10;
  };
}
