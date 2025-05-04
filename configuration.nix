{ config, pkgs, home-manager, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./config
      home-manager.nixosModules.default
  ];

  hardware.bluetooth.enable = true;

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices.root = {
      name = "root";
      device = "/dev/disk/by-uuid/e68c21be-8990-45c6-bf17-f685b1947499";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking = {
    hostName = "moskalets-nb";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  services.power-profiles-daemon.enable = true;

  users.users.moskalets = {
    isNormalUser = true;
    description = "Maxim Moskalets";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    google-chrome
    telegram-desktop
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.users.moskalets.home = {
    stateVersion = "25.05";
    username = "moskalets";
    homeDirectory = "/home/moskalets";
  };

  services.udev.packages = [ pkgs.qmk-udev-rules ];

  system.stateVersion = "25.05";
}

