{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # used for some packages
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

    # This one is only used when testing some packaging. You must change the path to the correct nixpkgs clone
    nixpkgs-local.url = "path:/home/tomasr/devel/fugit2-gpgme";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    notewrapper = {
      url = "github:tomasriveral/notewrapper";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs-notifier = {
      url = "github:tomasriveral/nixpkgs-notifier";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    caelestia-shell = {
      # based on quickshell. See https://github.com/caelestia-dots/shell
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
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
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;}
    ({
        flake = let
          system = "x86_64-linux";
          unfreePkgs = [
            "hplip"
            "vivify.vim"
            "cheatsheet.nvim"
          ];
          mkUnfreePredicate = pkg:
            builtins.elem (inputs.nixpkgs.lib.getName pkg) unfreePkgs;
          mkPkgs = nixpkgsInput:
            import nixpkgsInput {
              inherit system;
              config.allowUnfreePredicate = mkUnfreePredicate;
            };
          pkgs = mkPkgs inputs.nixpkgs;
          pkgs-unstable = mkPkgs inputs.nixpkgs-unstable;
          pkgs-local =  mkPkgs inputs.nixpkgs-local;
        in {
          inherit pkgs pkgs-unstable pkgs-local;
        };
      }
      // (inputs.import-tree ./modules));
}
