# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: {
  imports = [
    ./waybar.nix
  ];

  programs.waybar = lib.mkIf config.desktop.wayland.enable {
    enable = true;
    systemd.enable = true;
    excludeWidgets = if config.desktop.laptop.enable
      then [ "custom/ddcutil" ]
      else [ "battery" "group/group-backlight" ];
    ddcutil = {
      busNumber = 6;
    };
  };
}
