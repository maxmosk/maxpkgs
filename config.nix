{ config, pkgs, home-manager, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./config
    home-manager.nixosModules.default
  ];

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
      device = "/dev/disk/by-uuid/743c6a9d-8564-4d6f-9b7d-2a81364f32d0";
      preLVM = true;
      allowDiscards = true;
    };
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.moskalets = {
    isNormalUser = true;
    description = "Maxim Moskalets";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    users.moskalets.home = {
      stateVersion = "25.05";
      username = "moskalets";
      homeDirectory = "/home/moskalets";
    };
  };

  services.udev.packages = [ pkgs.qmk-udev-rules ];

  system.stateVersion = "25.05";
}

