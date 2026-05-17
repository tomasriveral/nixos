{
  inputs,
  pkgs,
  ...
}:
{
  # grub theme
  boot.loader.grub = {
    theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos; # if you want to use nixos grub theme
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
