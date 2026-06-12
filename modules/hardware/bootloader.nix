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
      extraConfig = ''
      '';
    };

    boot.loader.efi.canTouchEfiVariables = true;
  };
}
