{
  config,
  pkgs,
  pkgs-unstable,
  libs,
  inputs,
  ...
}: {
# Garbage collector of generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d"; # every week delete generations older than a month
  };
  # nixpkgs-review crashed my laptop multiple times.
  nix.settings.max-jobs = 2;
  nix.settings.cores = 2;
}
