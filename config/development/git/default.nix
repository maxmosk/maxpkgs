{ config, pkgs, ... }:

{
  home-manager.users.moskalets = {
    programs.git = {
      enable = true;
      userName = "Maxim Moskalets";
      userEmail = "maxmosk@list.ru";
    };
    home.packages = with pkgs; [
      git-review
    ];
  };
  programs.ssh.startAgent = true;
}
