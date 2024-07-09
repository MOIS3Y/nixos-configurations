# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    # hypr staff:
    ../../_shared/wayland/hyprland/hypridle.nix
    ../../_shared/wayland/hyprland/hyprpaper.nix
    ../../_shared/wayland/hyprland/hyprland.nix
    ../../_shared/wayland/hyprland/hyprlock.nix
    # waybar stuff:
    ../../_shared/wayland/waybar/waybar.nix
    # managment services and apps:
    ../../_shared/wayland/managment/avizo.nix
    ../../_shared/wayland/managment/swappy.nix
    ../../_shared/wayland/managment/swaylock.nix
    ../../_shared/wayland/managment/swaync.nix
    ../../_shared/wayland/managment/wlogout.nix
    ../../_shared/wayland/managment/wofi.nix
    # useful pkgs:
    ../../_shared/wayland/pkgs
  ];
  # override waybar:
  programs.waybar.excludeWidgets = [
    "custom/ddcutil"
  ];
}
