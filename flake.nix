{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  outputs = { self, nixpkgs }: {
    nixosConfigurations.moskalets-nb = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}
