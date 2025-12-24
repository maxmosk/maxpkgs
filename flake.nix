{
  description = "Maxim Moskalets NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    proxydetox-nixpkgs.url = "github:ein-shved/nixpkgs/proxydetox";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
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
      proxydetox-nixpkgs,
      home-manager,
      nix-index-database,
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
          "${proxydetox-nixpkgs}/nixos/modules/services/networking/proxydetox.nix"
          { services.proxydetox.package = proxydetox-nixpkgs.legacyPackages.${system}.pkgs.proxydetox; }
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
