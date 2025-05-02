{ config, pkgs, ... }:

{
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
  };
  programs = {
    hyprland = {
      enable = true;
    };
    hyprlock.enable = true;
    waybar.enable = true;
  };

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
