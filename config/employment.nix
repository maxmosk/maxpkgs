{ ... }:
{
  kl-ca-certificates.enable = true;
  rutoken.enable = true;
  kl-kerberos.enable = true;
  networking.kl-proxy = {
    enable = true;
    user = "moskalets";
  };
}
