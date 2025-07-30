# █▀█ █▀█ █▀▀ █▄░█ █▀█ █▀▀ █▄▄ ▀
# █▄█ █▀▀ ██▄ █░▀█ █▀▄ █▄█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  services.hardware.openrgb = {
    enable = config.host.hardware.openRGB.enable;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = config.host.hardware.motherboard.cpu;
  };
}