{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  networking = {
    hostName = "moskalets-nb";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  environment.systemPackages = with pkgs; [
    openvpn
  ];
}
