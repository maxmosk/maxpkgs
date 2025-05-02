{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
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
    wl-clipboard
  ];
  fonts.packages = with pkgs; [
    font-awesome
  ];
}
