{ config, lib, pkgs, ... }: {
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
    };
  };

  environment.systemPackages = with pkgs; [ openvpn openconnect ];

  #  user-nssdb = {
  #    enable = true;
  #    user = "moskalets";
  #  };
}
