{ config, pkgs, ... }:

{
  imports = [
    ./audio
    ./hyprland
    ./kanshi
  ];

  environment.systemPackages = with pkgs; [
    google-chrome
    telegram-desktop
  ];
}
