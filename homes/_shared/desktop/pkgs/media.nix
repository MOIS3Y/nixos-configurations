# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ pkgs, ... }: {
  home.packages = with pkgs; [
    amberol
    cassette
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
