# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    celluloid
    delfin
    transmission_4-gtk
    tremotesf
    vlc
  ];
}
