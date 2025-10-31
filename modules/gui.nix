{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.gui.enable = lib.mkEnableOption "Needs GUI";

  config = lib.mkIf config.maxpkgs.gui.enable {
    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      power-profiles-daemon.enable = true;
      blueman.enable = true;
    };
    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
      waybar.enable = true;
      nm-applet.enable = true;
    };

    fonts.packages = with pkgs; [ font-awesome ];
  };
}
