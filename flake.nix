{
  description = "Maxim Moskalets NixOS flake";

  inputs = {
    nixpkgs.url = "github:maxmosk/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kaspersky-nixpkgs = {
      url = "git+https://hqrndtfs.avp.ru/tfs/DefaultCollection/FT-TEE/_git/kaspersky-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      kaspersky-nixpkgs,
    }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.moskalets-nb = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          kaspersky-nixpkgs.nixosModules.modules
          kaspersky-nixpkgs.nixosModules.pkgs
          ./config.nix
          ./modules
          ./notsecrets.nix
        ];
      };
      homeConfigurations.moskalets = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = attrs;
        inherit pkgs;
        modules = [
          kaspersky-nixpkgs.homeManagerModules.modules
          kaspersky-nixpkgs.nixosModules.pkgs
          ./home.nix
          ./modules-home
          ./notsecrets-home.nix
        ];
      };
      inherit (nixpkgs) formatter;
    };
}
