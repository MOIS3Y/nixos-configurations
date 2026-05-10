# █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀ █▀▀ █▀█ █▀█ █▀▀ ▀
# █▄█ █▀█ █░▀░█ ██▄ ▄█ █▄▄ █▄█ █▀▀ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, ... }: {
  programs.gamescope = {
    enable = config.desktop.games.enable;
    capSysNice = true;
  };
}
