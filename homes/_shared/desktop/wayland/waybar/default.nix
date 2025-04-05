# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.wayland;
  in {
  imports = [
    ./waybar.nix
  ];
  programs.waybar = {
    enable = cfg.enable;
    systemd.enable = true;
    excludeWidgets = if config.desktop.laptop.enable
      then [ "custom/ddcutil" ]
      else [ "battery" "group/group-backlight" ];
    ddcutil = {
      busNumber = 6;
    };
  };
}
