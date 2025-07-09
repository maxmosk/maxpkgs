{
  description = "Maxim Moskalets NixOS flake";

  inputs = {
    nixpkgs.url = "github:maxmosk/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kaspersky-nixpkgs = {
      url = "git+file:/home/moskalets/shvedov-nixpkgs-local";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, kaspersky-nixpkgs }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.moskalets-nb = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          kaspersky-nixpkgs.nixosModules.modules
          kaspersky-nixpkgs.nixosModules.pkgs
          ./config.nix
          ./notsecrets.nix
        ];
      };
      homeConfigurations."moskalets" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ kaspersky-nixpkgs.homeManagerModules.modules ./home.nix ];
        };
    };
}
