{ ... }: {
  flake.nixosModule.disk = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      gnome-disk-utility
      udiskie
    ];
  };
  flake.nixosModule.disk-laptop = { ... }: {
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
