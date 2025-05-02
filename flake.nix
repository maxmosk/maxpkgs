{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.moskalets-nb = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { } // attrs;
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.moskalets = ./home.nix;
        }
      ];
    };
  };
}
