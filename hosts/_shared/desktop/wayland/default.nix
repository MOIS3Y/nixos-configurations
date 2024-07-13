# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  programs.hyprland = {
    enable = true;  
  };
  security.pam.services = {
    swaylock = {};  # ! require for swaylock
    hyprlock = {};  # ! require for hyprlock
  };
}
