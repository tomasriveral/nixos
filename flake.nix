# ~/nixos/flake.nix
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # used for some packages
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
# never got nixvim to wokrs. ):
#   nixvim = {
#	url = "github:nix-community/nixvim/nixos-25.11";
   # };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager,... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = false;
    };
  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs pkgs-unstable;}; 
       modules = [
	  ./hosts/laptop/configuration.nix
        ];
      };
    };
# we use home-manager directly inside of configuration.nix
# last time i tried to use flake i broke everything ):
#    homeManagerConfigurations = {
#      tomasr = home-manager.lib.homeManagerConfiguration {
#        pkgs = pkgs;
#        system = "x86_64-linux";
#        username = "tomasr";
#        homeDirectory = "/home/tomasr";
#	modules = [
#		./hosts/laptop/home.nix
#		#nixvim.homeModules.default
#];
        # Import your Home Manager module
       # configuration = ./hosts/laptop/home.nix;

       # extraSpecialArgs = { inherit inputs; };
     # };
    #};
  #};
};
}
