{ config, pkgs, ... }:

{
  imports = [
    ./home-config
  ];

  home.username = "moskalets";
  home.homeDirectory = "/home/moskalets";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    btop
  ];

  programs.home-manager.enable = true;

  programs.nix-index-database.comma.enable = true;

  programs.keepassxc = {
    enable = true;
    settings = {
      Browser = {
        Enabled = true;
        CustomBrowserType = 2; # Brave browser
      };
      GUI.ApplicationTheme = "dark";
    };
  };
}
