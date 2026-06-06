_: {
  flake.diskoConfigurations.desktop = _: {
    disko.devices = {
      disk = {
        ssd = {
          # Replace with actual disk id from:
          # ls -l /dev/disk/by-id
          device = "/dev/disk/by-id/REPLACE_SSD_ID";

          type = "disk";

          content = {
            type = "gpt";

            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";

                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };

              root = {
                size = "100%";

                content = {
                  type = "btrfs";

                  extraArgs = [ "-f" ];

                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@snapshots" = {
                      mountpoint = "/.snapshots";
                    };
                  };
                };
              };
            };
          };
        };

        hdd = {
          # Replace with actual disk id
          device = "/dev/disk/by-id/REPLACE_HDD_ID";

          type = "disk";

          content = {
            type = "gpt";

            partitions = {
              data = {
                size = "100%";

                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/data";
                };
              };
            };
          };
        };
      };
    };
  };
}
