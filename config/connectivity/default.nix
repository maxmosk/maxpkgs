{
  config,
  lib,
  pkgs,
  ...
}:
{
  hardware.bluetooth.enable = true;

  networking = {
    hostName = "moskalets-nb";
    kl-wired = {
      enable = true;
      login = "Moskalets";
    };
    klc = {
      enable = true;
      login = "Moskalets";
    };
    klcvpn.enable = true;
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      plugins = [
        pkgs.networkmanager-openvpn
        pkgs.networkmanager-openconnect
      ];
    };
  };
}
