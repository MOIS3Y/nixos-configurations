# ▀▄▀ █▀█ ▄▀█ █▀▄ █▄░█ █▀▀ █▀█ ▀
# █░█ █▀▀ █▀█ █▄▀ █░▀█ ██▄ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, ... }: {
  hardware.xpadneo = {
    enable = config.desktop.games.xpadneo.enable;
  };
}