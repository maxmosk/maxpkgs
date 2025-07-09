{ config, pkgs, ... }:

{
  imports = [ ./audio ./hyprland ];

  environment.systemPackages = with pkgs; [
    google-chrome
    telegram-desktop
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    home-manager
  ];

  programs.chromium = {
    enable = true;
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [ "ru-RU" "en-US" ];
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
}
