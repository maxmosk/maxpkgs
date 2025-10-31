{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.employment.enable = lib.mkEnableOption "Kaspersky workstation";

  config = lib.mkIf config.maxpkgs.employment.enable {
    nssdb.enable = true;
    llm.enable = true;
    llm-nvim.enable = true;
    kl-git = {
      enable = true;
      name = "Maxim Moskalets";
      email = "Maxim.Moskalets@kaspersky.com";
      gerritName = "moskalets";
    };
  };
}
