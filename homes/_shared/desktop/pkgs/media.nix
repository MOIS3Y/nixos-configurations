# █▀▄▀█ █▀▀ █▀▄ █ ▄▀█ ▀
# █░▀░█ ██▄ █▄▀ █ █▀█ ▄
# -- -- -- -- -- -- -- 

{ pkgs, ... }: {
  home.packages = with pkgs; [
    amberol
    cassette
    celluloid
    delfin
    #! broken build  electron-33.4.11 is EOL
    #? see https://github.com/NixOS/nixpkgs/issues/404494
    # feishin 
    imv
    shotwell
    transmission_4-gtk
    tremotesf
    vlc
  ];
}
