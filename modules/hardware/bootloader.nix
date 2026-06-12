_: let
  wallpaper1 = ../../assets/wallpaper1.jpg;
  wallpaper2 = ../../assets/wallpaper2.jpg;
  wallpaper3 = ../../assets/wallpaper3.jpg;
  wallpaper4 = ../../assets/wallpaper4.jpg;
  wallpaper5 = ../../assets/wallpaper5.jpg;
in {
  flake.nixosModules.bootloader = _: {
    # disable other bootloaders
    boot.loader.systemd-boot.enable = false;
    boot.loader.grub.enable = false;

    boot.loader.limine = {
      enable = true;
      efiSupport = true;
      maxGenerations = 128;
      style = {
        wallpaperStyle = "centered";
        wallpapers = [
          wallpaper1
          wallpaper2
          wallpaper3
          wallpaper4
          wallpaper5
        ];
      };
    };

    boot.loader.efi.canTouchEfiVariables = true;
  };
}
