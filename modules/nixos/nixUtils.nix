{
  pkgs-unstable,
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

  #manix is unhappy without this
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs.outPath}"
    "home-manager=${inputs.home-manager.outPath}"
  ];

  #adds nixos experimental features:
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs-unstable; [
  nixpkgs-review
  nixfmt-tree
  treefmt
  nixd
  deadnix
  alejandra
  ];
}
