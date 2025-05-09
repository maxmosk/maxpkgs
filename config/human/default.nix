{ config, pkgs, ... }:

{
  imports = [
    ./audio
    ./hyprland
    ./kanshi
  ];

  environment.systemPackages = with pkgs; [
    google-chrome
    telegram-desktop
  ];

  programs.chromium = {
    enable = true;
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "ru-RU"
        "en-US"
      ];
    };
  };
}
