{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.games.enable = lib.mkEnableOption "Gaming staff";

  config = lib.mkIf config.maxpkgs.games.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    users.extraGroups.vboxusers.members = [ "moskalets" ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
