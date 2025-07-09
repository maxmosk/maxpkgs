{
  config,
  pkgs,
  home-manager,
  kaspersky-nixpkgs,
  ...
}:

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
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  home-manager = {
    useGlobalPkgs = true;
    users.moskalets = {
      imports = [
        ./home.nix
        kaspersky-nixpkgs.homeManagerModules.modules
      ];
    };
  };

  services.udev.packages = [
    pkgs.qmk-udev-rules
    pkgs.stlink
  ];
  services.thermald.enable = true;
  programs.pulseview.enable = true;
  programs.appimage.enable = true;
  programs.ssh.startAgent = true;

  users.users.moskalets = {
    isNormalUser = true;
    description = "Maxim Moskalets";
    name = "moskalets";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  system.stateVersion = "25.05";
}
