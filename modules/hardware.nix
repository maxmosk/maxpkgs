{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.maxpkgs.hardware.laptop = lib.mkEnableOption "Laptop for work";

  config.boot = lib.mkIf config.maxpkgs.hardware.laptop {
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
}
