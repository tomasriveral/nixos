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
  
          luks = {
            size = "100%";
  
            content = {
              type = "luks";
              name = "cryptroot";
  
              # You will type this password at boot.
              settings.allowDiscards = true;
  
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
  
                  # Keyfile storage.
                  # This subvolume will contain the key used
                  # to unlock the HDD automatically.
                  "@keys" = {
                    mountpoint = "/keys";
                  };
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
        luks = {
          size = "100%";

          content = {
            type = "luks";

            name = "cryptdata";

            # IMPORTANT:
            # This keyfile will be created after installation.
            # The SSD unlocks first.
            # Then this keyfile unlocks the HDD automatically.
            settings = {
              keyFile = "/keys/hdd.key";
            };

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
