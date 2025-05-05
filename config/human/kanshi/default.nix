{ config, pkgs, ... }:

{
  home-manager.users.moskalets.services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "laptop";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "hdmi";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
        ];
      }
    ];
  };
}

