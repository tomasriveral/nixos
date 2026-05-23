{ inputs, ... }: {

flake.modules.nixos.common = { ... }: {

	imports = [ inputs.home-manager.nixosModules.default ];
};

}
