{ config, pkgs, ... }: {
  home = {
    stateVersion = "25.05";
    username = "moskalets";
    homeDirectory = "/home/moskalets";
    pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    packages = with pkgs; [ git-review git-lfs ];
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      . ~/oldbashrc
    '';
    profileExtra = ''
      . ~/oldprofile
    '';
  };
  programs.git = {
    enable = true;
    userName  = "Maxim Moskalets";
    userEmail = "Maxim.Moskalets@kaspersky.com";
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.clang-tools
    ];
    plugins = with pkgs.vimPlugins; [clangd_extensions-nvim nvim-lspconfig];
    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.mouse = 'a'
    '';
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "screen-256color";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile (./. + "/resources/hyprland.conf");
  };
  services.hyprpaper = {
    enable = true;
    settings = let anime = builtins.toString (./. + "/resources/anime.jpg");
    in {
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
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "tray"
        "idle_inhibitor"
        "hyprland/language"
        "pulseaudio"
        "backlight"
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
      network.on-click =
        "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
      bluetooth.on-click = "${pkgs.blueman}/bin/blueman-manager";
    };
  };
  programs.kitty = {
    enable = true;
    settings.font_size = 18;
  };
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
    };
    listener = [
      {
        timeout = 120;
        on-timeout = "brightnessctl -s set 10";
        on-resume = "brightnessctl -r";
      }
      {
        timeout = 300;
        on-timeout = "loginctl lock-session";
      }
      {
        timeout = 360;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
      {
        timeout = 600;
        on-timeout = "systemctl suspend";
      }
    ];
  };
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "laptop";
        profile.outputs = [{
          criteria = "eDP-1";
          status = "enable";
        }];
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
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
