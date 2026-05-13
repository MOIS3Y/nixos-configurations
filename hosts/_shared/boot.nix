# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --
# Sets up the bootloader, kernel parameters and early boot modules.

{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.host) hardware;
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.host.boot;
  theme = inputs.distro-grub-themes.packages.${system}."${cfg.grubTheme}-grub-theme";
in
{
  boot = {
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    extraModulePackages =
      [ ] ++ lib.optionals hardware.ddcci.enable [ config.boot.kernelPackages.ddcci-driver ];
    kernelModules = lib.unique (
      [
        # add base kernel modules here ...
      ]
      ++ lib.optionals (hardware.motherboard.cpu == "intel") [ "i2c-i801" ]
      ++ lib.optionals (hardware.motherboard.cpu == "amd") [ "i2c-piix4" ]
      ++ lib.optionals hardware.coolercontrol.enable [
        "coretemp"
        "nct6775"
      ]
      ++ lib.optionals hardware.ddcci.enable [
        "ddcci_backlight"
        "i2c-dev"
      ]
      ++ lib.optionals hardware.openRGB.enable [ "i2c-dev" ]
    );
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
        gfxmodeEfi = "1920x1080";
        splashImage = "${theme}/splash_image.jpg";
        inherit theme;
      };
    };
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "connect";
    };
  };
}
