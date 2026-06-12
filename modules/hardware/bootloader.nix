_: {
  flake.nixosModules.bootloader = {
    inputs,
    pkgs,
    ...
  }: {
    # disable other bootloaders
    boot.loader.systemd-boot.enable = false;
    boot.loader.grub.enable = false;

    boot.loader.limine = {
      enable = true;
      efiSupport = true;
    };

    boot.loader.efi.canTouchEfiVariables = true;
  };
}
