# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    celluloid
    delfin
    imv
    transmission_4-gtk
    tremotesf
    vlc
  ];
}
