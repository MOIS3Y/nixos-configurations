# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{config, pkgs, ...}: {
  
  boot.kernelParams = [ "quiet" ];
  boot.consoleLogLevel = 3;
  
  imports = [
    ../../_shared/boot/plymouth.nix
    ./loader.nix
  ];
}
