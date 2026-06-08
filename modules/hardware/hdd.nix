_: {
  flake.nixosModules.hdd = {
    fileSystems."/home/tomasr/hdd" = {
      device = "/dev/disk/by-uuid/cbe24588-e04f-4ffc-ba44-6fe6ec6d6850";
      fsType = "ext4";
    };
  };
}
