# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  imports = [
    ./hypr
    ./waybar

    ./avizo.nix
    ./swappy.nix
    ./swaylock.nix
    ./swaync.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
