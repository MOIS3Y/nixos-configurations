# ▀▄▀ █▀ █▀▀ █▀ █▀ █ █▀█ █▄░█ ▀
# █░█ ▄█ ██▄ ▄█ ▄█ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: {
  xsession.enable = lib.mkIf config.desktop.xorg.enable true;
}