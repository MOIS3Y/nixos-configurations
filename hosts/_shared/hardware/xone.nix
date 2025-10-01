# ▀▄▀ █▀█ █▄░█ █▀▀ ▀
# █░█ █▄█ █░▀█ ██▄ ▄
# -- -- -- -- -- -- 

{ config, ... }: {
  hardware.xone = {
    #? fix last firmware update Xbox One Wireless Controller (bluetooth rumble)
    enable = config.desktop.games.xpadneo.enable;
  };
}
