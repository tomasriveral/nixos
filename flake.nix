{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # used for some packages
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      # based on quickshell. See https://github.com/caelestia-dots/shell
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    microPlugins-vivify = {
      url = "git+https://codeberg.org/gibbert/micro-vivify";
      flake = false;
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    import-tree.url = "github:vic/import-tree"; # imports ./modules recursively
  };
  outputs = inputs @ { flake-parts, ... }:
  /*@ inputs: let
    unfreePkgs = [
      "hplip"
      "vivify.vim"
      "cheatsheet.nvim"
    ];

    mkUnfreePredicate = pkg:
      builtins.elem (nixpkgs.lib.getName pkg) unfreePkgs;

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;

      config.allowUnfreePredicate = mkUnfreePredicate;
    };
    in */
    flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree ./modules);
  }
