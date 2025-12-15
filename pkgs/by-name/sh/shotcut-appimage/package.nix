{
  lib,
  fetchurl,
  appimageTools,
}:

appimageTools.wrapType2 rec {
  pname = "shotcut-appimage";
  version = "25.10";

  src = fetchurl {
    url = "https://github.com/mltframework/shotcut/releases/download/v${version}.31/shotcut-linux-x86_64-25.11.2.AppImage";
    hash = "sha256-6vROtmARbfNzbTt73hPJwSUnbMnIFjYckeRhcBkkQR4=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
}
