# █░█░█ ▄▀█ █▄█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.wayland;
in {
  options.desktop.wayland = with lib; {
    enable = mkEnableOption "Enable wayland environment";
  };
  config = with pkgs; with lib; mkIf cfg.enable {
    programs.hyprland = {
      enable = true;  
    };
    security.pam.services = {
      swaylock = {};  # ! require for swaylock
      hyprlock = {};  # ! require for hyprlock
    };
  };
}
