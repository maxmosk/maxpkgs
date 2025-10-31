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

  maxpkgs.audio.enable = true;
  maxpkgs.employment.enable = true;
  maxpkgs.games.enable = true;
  maxpkgs.gui.enable = true;
  maxpkgs.networking.enable = true;

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
      device = "/dev/disk/by-uuid/743c6a9d-8564-4d6f-9b7d-2a81364f32d0";
      preLVM = true;
      allowDiscards = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  home-manager = {
    useGlobalPkgs = true;
    users.moskalets = {
      imports = [
        kaspersky-nixpkgs.homeManagerModules.modules
        ./home.nix
        ./modules-home
      ];
    };
  };

  programs.pay-respects.enable = true;
  security.sudo-rs.enable = true;
  services.udev.packages = [
    pkgs.qmk-udev-rules
    pkgs.stlink
    pkgs.libsigrok
  ];

  services.thermald.enable = true;
  services.openssh.enable = true;
  programs.pulseview.enable = true;
  programs.appimage.enable = true;
  programs.ssh.startAgent = true;
  programs.chromium = {
    enable = true;
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "ru-RU"
        "en-US"
      ];
      "AuthNegotiateDelegateAllowlist" = "*.kaspersky.com,*.avp.ru";
      "AuthServerAllowlist" = "*.kaspersky.com,*.avp.ru";
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
    };
  };

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

  system.stateVersion = "25.05";
}
