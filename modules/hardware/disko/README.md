Note : ChatGPT helped me with the disko setup

This is the layout I'd start with. It's not fully copy-paste ready because you'll need to fill in the actual disk IDs after booting the installer, but it captures the architecture you described:

* SSD: LUKS → Btrfs
* HDD: LUKS → ext4
* One password entered at boot
* HDD unlocked using a keyfile stored on the SSD
* Suitable for a desktop host

# disko/desktop.nix
```

{
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
```

};
}

A few notes:

### 1. You'll need the disk IDs

On the installer:

```bash
ls -l /dev/disk/by-id
```

Then replace:

```text
REPLACE_SSD_ID
REPLACE_HDD_ID
```

with the actual values.

---

### 2. The HDD keyfile is a second step

After installation:

```bash
sudo mkdir -p /keys
sudo chmod 700 /keys

sudo dd if=/dev/urandom of=/keys/hdd.key bs=4096 count=1
sudo chmod 000 /keys/hdd.key
```

Then add the key to the HDD LUKS container:

```bash
sudo cryptsetup luksAddKey /dev/disk/by-id/ACTUAL_HDD_PARTITION /keys/hdd.key
```

Now:

```text
boot
↓
enter SSD password
↓
SSD unlocks
↓
keyfile becomes available
↓
HDD unlocks automatically
```

One password.

---

### 3. Btrfs subvolumes

I intentionally kept it simple:

```text
/
/home
/nix
/.snapshots
```

This is a very common NixOS layout.

---

### 4. Swap

I haven't included swap because there are a few valid choices:

* swapfile on Btrfs
* swap partition inside the SSD LUKS container
* zram only

I'd probably use **zram + a small swapfile** unless you have a very specific workload.

---

### 5. Dendritic adaptation

The actual Disko definition above won't change much.

The dendritic part is mostly wrapping it in your top-level module structure, something like:

```nix
{
  flake.diskoConfigurations.desktop = {
    imports = [
      ./desktop-disko.nix
    ];
  };
}
```

or whatever convention your repository uses.

The storage design itself remains the same.
