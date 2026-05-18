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
  };
  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    ...
  } @ inputs: let
    system = "x86_64-linux";

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
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs pkgs-unstable;};
        modules = [
          ./hosts/laptop/configuration.nix
          # solves evaluation warning
          /*
          You have set specialArgs.pkgs, which means that options like nixpkgs.config
          and nixpkgs.overlays will be ignored. If you wish to reuse an already created
          pkgs, which you know is configured correctly for this NixOS configuration,
          please import the `nixosModules.readOnlyPkgs` module from the nixpkgs flake or
          `(modulesPath + "/misc/nixpkgs/read-only.nix"), and set `{ nixpkgs.pkgs = <your pkgs>; }`.
          This properly disables the ignored options to prevent future surprises.
          */
          {
            nixpkgs.config.allowUnfreePredicate = mkUnfreePredicate;
          }
        ];
      };
    };
    # we use home-manager directly inside of configuration.nix
  };
}
