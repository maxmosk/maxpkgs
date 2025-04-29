{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.root = {
    name = "root";
    device = "/dev/disk/by-uuid/e68c21be-8990-45c6-bf17-f685b1947499";
    preLVM = true;
    allowDiscards = true;
  };

  networking.hostName = "moskalets-nb";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.moskalets = {
    isNormalUser = true;
    description = "Maxim Moskalets";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  services.xserver.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    google-chrome
    kitty
    wofi
    telegram-desktop
    brightnessctl
    kanshi
  ];

  system.copySystemConfiguration = true;

  system.stateVersion = "25.05";
}

