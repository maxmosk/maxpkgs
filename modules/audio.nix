{
  config,
  lib,
  ...
}:
{
  options.maxpkgs.audio.enable = lib.mkEnableOption "Needs audio";

  config = lib.mkIf config.maxpkgs.audio.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
