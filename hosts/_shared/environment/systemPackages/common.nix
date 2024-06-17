# █▀▀ █▀█ █▀▄▀█ █▀▄▀█ █▀█ █▄░█ ▀
# █▄▄ █▄█ █░▀░█ █░▀░█ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cmatrix
    neofetch
    nitch
    tty-clock
  ];
}
