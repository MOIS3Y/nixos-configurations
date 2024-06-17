# ▀▄▀ █▀█ █▀█ █▀▀ ▀
# █░█ █▄█ █▀▄ █▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    # ../../_shared/xorg/cbatticon.nix
    ../../_shared/xorg/dunst.nix
    ../../_shared/xorg/picom.nix
    ../../_shared/xorg/pkgs.nix
    ../../_shared/xorg/rofi.nix
    ../../_shared/xorg/xidlehook.nix
    ../../_shared/xorg/xresources.nix
    ../../_shared/xorg/xss-lock.nix
  ];
}
