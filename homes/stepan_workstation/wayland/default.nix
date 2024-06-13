# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/wayland/avizo.nix
    ../../_shared/wayland/hypridle.nix
    ../../_shared/wayland/hyprland.nix
    ../../_shared/wayland/swappy.nix
    ../../_shared/wayland/swaylock.nix
    ../../_shared/wayland/swaync.nix
    ../../_shared/wayland/waybar.nix
    ../../_shared/wayland/wlogout.nix
    ../../_shared/wayland/wofi.nix
  ];
}
