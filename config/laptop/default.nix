{ config, pkgs, ... }:

{
  services.thermald.enable = true;
  environment.systemPackages = with pkgs; [ btop ];

  kl-ca-certificates.enable = true;
  rutoken.enable = true;
}
