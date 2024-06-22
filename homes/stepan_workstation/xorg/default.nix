# ▀▄▀ █▀█ █▀█ █▀▀ ▀
# █░█ █▄█ █▀▄ █▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    # managment services:
    ../../_shared/xorg/managment/dunst.nix
    ../../_shared/xorg/managment/picom.nix
    ../../_shared/xorg/managment/rofi.nix
    ../../_shared/xorg/managment/xidlehook.nix
    ../../_shared/xorg/managment/xresources.nix
    ../../_shared/xorg/managment/xss-lock.nix
    # useful pkgs:
    ../../_shared/xorg/pkgs
  ];
}
