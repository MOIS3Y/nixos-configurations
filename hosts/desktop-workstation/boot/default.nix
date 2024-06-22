# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{config, pkgs, ...}: {

  imports = [
    ../../_shared/boot/amd.nix
    ../../_shared/boot/plymouth.nix
    ./loader.nix
  ];

  boot = {
    kernelParams = [ "quiet" ];
    extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    kernelModules = ["i2c_dev" "ddcci_backlight"];  #! MSI Monitor, Model:G2712
    consoleLogLevel = 3;
  };
}
