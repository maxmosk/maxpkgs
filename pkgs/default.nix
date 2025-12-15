{ nixpkgs, ... }:
let
  by-name-overlay = import "${nixpkgs}/pkgs/top-level/by-name-overlay.nix" ./by-name;
in
{
  nixpkgs.overlays = [ by-name-overlay ];
}
