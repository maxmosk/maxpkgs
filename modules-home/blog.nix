{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.blog.enable = lib.mkEnableOption "Blogging tools";

  config.home.packages =
    with pkgs;
    lib.mkIf config.maxpkgs.blog.enable [
      webcamoid
      shotcut
      shotcut-appimage
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.ru_RU
    ];
}
