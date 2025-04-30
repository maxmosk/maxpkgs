{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
  };
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    brightnessctl
    playerctl
  ];
}
