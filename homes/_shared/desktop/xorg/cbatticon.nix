# █▀▀ █▄▄ ▄▀█ ▀█▀ ▀█▀ █ █▀▀ █▀█ █▄░█ ▀
# █▄▄ █▄█ █▀█ ░█░ ░█░ █ █▄▄ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: lib.mkIf config.desktop.xorg.enable {
  services.cbatticon = {
    enable = true;
    lowLevelPercent = 20;
    criticalLevelPercent = 5;
  };
}
