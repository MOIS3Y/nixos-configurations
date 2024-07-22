# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    amberol
    celluloid
    delfin
    feishin
    imv
    shotwell
    transmission_4-gtk
    tremotesf
    vlc
  ];
}
