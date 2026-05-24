_: {
  # unused at the moment see ../hardware/battery.nix
  flake.homeModules.batsignal = _: {
    services.batsignal.enable = true;
  };
}
