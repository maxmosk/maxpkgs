{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.networking.enable = lib.mkEnableOption "Needs network connection";

  config = lib.mkIf config.maxpkgs.networking.enable {
    networking = {
      hostName = "moskalets-nb";
      networkmanager = {
        enable = true;
        wifi.powersave = true;
        plugins = [
          pkgs.networkmanager-openvpn
        ];
      };
    };
  };
}
