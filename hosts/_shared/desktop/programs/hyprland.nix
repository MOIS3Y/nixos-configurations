# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  programs.hyprland = {
    enable = builtins.elem "hyprland" config.desktop.wayland.compositors;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  # TODO: move it to security module then check if desktop.wayland.enable = true;
  security.pam.services = {
    swaylock = {};  # ! require for swaylock
    hyprlock = {};  # ! require for hyprlock
  };
}