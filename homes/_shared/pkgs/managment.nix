# █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
  ];
}
