# █░█ █▄█ █▀█ █▀█ ▀
# █▀█ ░█░ █▀▀ █▀▄ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];
}
