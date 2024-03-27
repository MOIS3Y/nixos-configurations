# ▀▄▀ █▀█ █▀█ █▀▀ ▀
# █░█ █▄█ █▀▄ █▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./picom.nix
    ./rofi.nix
    ./xidlehook.nix
    ./xresources.nix
    ./xss-lock.nix
  ];
}
