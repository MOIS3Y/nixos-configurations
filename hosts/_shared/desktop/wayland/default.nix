# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  programs.hyprland = {
    enable = true;
    package = pkgs.extra.hyprland;
    portalPackage = pkgs.extra.xdg-desktop-portal-hyprland;
  };
  security.pam.services = {
    swaylock = {};  # ! require for swaylock
    hyprlock = {};  # ! require for hyprlock
  };
}
