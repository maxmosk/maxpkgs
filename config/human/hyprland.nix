{ config, pkgs, ... }:

{
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
  };
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    nm-applet.enable = true;
  };
  # Needed for waybar
  services = {
    power-profiles-daemon.enable = true;
    blueman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    wofi
    brightnessctl
    playerctl
    wl-clipboard
    hyprpaper
    grim
    slurp
  ];
  fonts.packages = with pkgs; [ font-awesome ];
}
