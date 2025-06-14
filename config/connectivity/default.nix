{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  networking = {
    hostName = "moskalets-nb";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    openvpn
  ];
}
