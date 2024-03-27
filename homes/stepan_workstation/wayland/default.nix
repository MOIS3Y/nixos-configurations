# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./swappy.nix
    ./swaylock.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
