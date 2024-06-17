# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    celluloid
    transmission-gtk
    vlc
  ];
}
