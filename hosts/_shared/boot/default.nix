# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{ config, lib, ... }: let
  inherit (config.host)
    hardware;
in {
  imports = [
    ./loader.nix
    ./plymouth.nix
  ];
  boot = {
    # ? silent boot (see initrd.verbose description): 
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    # ? kernel modules:
    extraModulePackages = [ ]
      ++ lib.optionals hardware.ddcci.enable [
        config.boot.kernelPackages.ddcci-driver
    ];
    kernelModules = [ ]
      ++ lib.optionals (hardware.motherboard.cpu == "intel") [ "i2c-i801" ]
      ++ lib.optionals (hardware.motherboard.cpu == "amd") [ "i2c-piix4" ]
      ++ lib.optionals hardware.coolercontrol.enable [ "coretemp" "nct6775" ]
      ++ lib.optionals hardware.ddcci.enable [ "ddcci_backlight" ]
      ++ lib.optionals (
        (hardware.openRGB.enable or false) ||
        (hardware.ddcci.enable or false)
      ) [ "i2c-dev" ]
    ;
  };
}
