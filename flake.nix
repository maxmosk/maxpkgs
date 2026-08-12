{
  description = "Home Manager configuration of Maxim Moskalets";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kaspersky-nixpkgs = {
      url = "git+https://hqrndtfs.avp.ru/tfs/DefaultCollection/FT-TEE/_git/kaspersky-nixpkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-index-database,
      kaspersky-nixpkgs,
      ...
    }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      lib = pkgs.lib;
    in
    {
      homeConfigurations.moskalets = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = attrs;
        inherit pkgs;

        modules = [
          nix-index-database.homeModules.default
          kaspersky-nixpkgs.homeManagerModules.modules
          kaspersky-nixpkgs.nixosModules.pkgs
          ./home.nix
        ];
      };
    };
}
