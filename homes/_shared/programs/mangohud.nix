# █▀▄▀█ ▄▀█ █▄░█ █▀▀ █▀█ █░█ █░█ █▀▄ ▀
# █░▀░█ █▀█ █░▀█ █▄█ █▄█ █▀█ █▄█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  programs.mangohud = {
    enable = lib.mkDefault config.desktop.games.enable;
  };
}
