# ▀▄▀ █▀█ █▀█ █▀▀ ▀
# █░█ █▄█ █▀▄ █▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  imports = [
    ./cbatticon.nix
    ./dunst.nix
    ./picom.nix
    ./pkgs.nix
    ./rofi.nix
    ./xidlehook.nix
    ./xresources.nix
    ./xss-lock.nix
  ];
  xsession.enable = lib.mkIf config.desktop.xorg.enable true;
}
