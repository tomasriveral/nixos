{ ... }: {
  # unused at the moment see ../hardware/battery.nix
  flake.homeModules.batsignal = { ... }: {
    services.batsignal.enable = true;
  };
}
