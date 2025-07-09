{ inputs, config, pkgs, home-manager, ... }:

{
  imports =
    [ ./hardware-configuration.nix ./config home-manager.nixosModules.default ];

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
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    users.moskalets = { imports = [ ./home.nix ]; };
  };

  services.udev.packages = [ pkgs.qmk-udev-rules ];
  programs.pulseview.enable = true;

  kl-kerberos.enable = true;
  networking.kl-proxy.enable = true;
  user = {
    name = "moskalets";
    humanName = "Maxim Moskalets";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}

