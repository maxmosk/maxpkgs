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
    hyprpaper
  ];
  fonts.packages = with pkgs; [
    font-awesome
  ];

  home-manager.users.moskalets =
  {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      extraConfig = builtins.readFile (./. + "/hyprland.conf");
    };
    services.hyprpaper = {
      enable = true;
      settings =
      let
        anime = builtins.toString (./. + "/anime.jpg");
      in
      {
        wallpaper = ", ${anime}";
        preload = anime;
      };
    };
  };
}
