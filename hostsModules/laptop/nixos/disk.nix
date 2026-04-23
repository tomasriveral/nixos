{
  config,
  pkgs,
  pkgs-unstable,
  libs,
  inputs,
  ...
}: {
  # i found swap necessary when running nixpkgs review
  swapDevices = [{
      device = "/swapfile";
      size = 16384; # 16 GB
    }
  ];
  boot.kernel.sysctl."vm.swappiness" = 10;
}
