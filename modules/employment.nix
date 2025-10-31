{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.employment.enable = lib.mkEnableOption "Kaspersky workstation";

  config = lib.mkIf config.maxpkgs.employment.enable {
    kl-ca-certificates.enable = true;
    rutoken.enable = true;
    kl-kerberos.enable = true;

    networking = {
      kl-proxy = {
        enable = true;
        user = "moskalets";
      };
      kl-wired = {
        enable = true;
        login = "Moskalets";
      };
      klc = {
        enable = true;
        login = "Moskalets";
      };
      klcvpn.enable = true;
      networkmanager.plugins = [
        pkgs.networkmanager-openconnect
      ];
    };

    services = {
      isy = {
        enable = true;
        owners = [ "Maxim Moskalets" ];
        services = [ "5013314" ];
      };

      kesl = {
        enable = true;
        eula.agreed = true;
        privacy-policy.agreed = true;
      };

      klnagent = {
        enable = true;
        server = "HQKSC1.AVP.RU";
        eula.agreed = true;
      };
    };
  };
}
