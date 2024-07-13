# █▀▄▀█ ▄▀█ █▄░█ █▀▀ █▀█ █░█ █░█ █▀▄ ▀
# █░▀░█ █▀█ █░▀█ █▄█ █▄█ █▀█ █▄█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.games.enable {
  programs.mangohud = {
    enable = true;
  };
}
