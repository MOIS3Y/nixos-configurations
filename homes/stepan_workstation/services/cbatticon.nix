# █▀▀ █▄▄ ▄▀█ ▀█▀ ▀█▀ █ █▀▀ █▀█ █▄░█ ▀
# █▄▄ █▄█ █▀█ ░█░ ░█░ █ █▄▄ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  services.cbatticon = {
    enable = true;
    lowLevelPercent = 20;
    criticalLevelPercent = 5;
  };
}