# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./avizo.nix
    ./hypridle.nix
    ./hyprland.nix
    ./swappy.nix
    ./swaylock.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
