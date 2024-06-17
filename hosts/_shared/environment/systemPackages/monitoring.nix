# █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█ █ █▄░█ █▀▀ ▀
# █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄ █ █░▀█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bottom
    htop
    lm_sensors
    ncdu
  ];
}
