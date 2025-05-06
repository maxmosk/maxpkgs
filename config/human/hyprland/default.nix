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
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings.bar = {
        height = 30;
        spacing = 4;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = [
          "tray"
          "hyprland/language"
          "pulseaudio"
          "network"
          "bluetooth"
          "memory"
          "cpu"
          "temperature"
          "battery"
          "clock"
          "power-profiles-daemon"
        ];
        pulseaudio.on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        temperature.thermal-zone = 8; # TCPU zone in /sys/class/thermal/
        network.on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        bluetooth.on-click = "${pkgs.blueman}/bin/blueman-manager";
      };
    };
  };
}
