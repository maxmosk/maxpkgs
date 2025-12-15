{
  config,
  pkgs,
  nix-index-database,
  home-manager,
  kaspersky-nixpkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./config
    ./pkgs
    home-manager.nixosModules.default
    nix-index-database.nixosModules.nix-index
  ];

  maxpkgs.audio.enable = true;
  maxpkgs.employment.enable = true;
  maxpkgs.games.enable = true;
  maxpkgs.gui.enable = true;
  maxpkgs.networking.enable = true;
  maxpkgs.hardware.laptop = true;

  hardware.bluetooth.enable = true;

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
  programs.nix-index-database.comma.enable = true;
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
