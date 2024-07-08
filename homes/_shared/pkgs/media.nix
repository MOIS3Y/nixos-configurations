# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    celluloid
    delfin
    transmission-gtk
    tremotesf
    vlc
  ];
}
