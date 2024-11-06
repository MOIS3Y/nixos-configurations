# █▄░█ █▀▀ ▀█▀ █░█░█ █▀█ █▀█ █▄▀ ▀
# █░▀█ ██▄ ░█░ ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wireguard-tools
    google-chrome
    system-config-printer
  ];
}
