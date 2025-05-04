{ config, pkgs, ... }:

{
  home-manager.users.moskalets.home.packages = with pkgs; [
    freecad
    orca-slicer
  ];
}
