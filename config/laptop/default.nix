{ config, pkgs, ... }:

{
  services.thermald.enable = true;
  environment.systemPackages = with pkgs; [
    btop
  ];
}
