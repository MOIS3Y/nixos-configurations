# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: let
  bars = import ./bars.nix { inherit config lib; };
  styles = import ./styles.nix { inherit config;};
  inherit (lib)
    mkOption
    types;
  in {
  options.programs.waybar = {
    excludeWidgets = mkOption {
      default = [];
      type = with types; listOf (enum [
        "battery"
        "group/group-backlight"
        "custom/ddcutil"
      ]);
      description = "Exclude widgets from current bar.";
    };
  };
  config = {
    programs.waybar = {
      # ? waybar has configuration only for hyprland
      enable = if config.wayland.windowManager.hyprland.enable
        then true
        else false;
      systemd.enable = true;
      excludeWidgets = if !config.desktop.devices.ddcci.enable
        then [ "custom/ddcutil" ]
        else [ "battery" "group/group-backlight" ];
      settings = {
        primaryBar = bars.primary;
      };
      style = styles.primary;
    };
  };
}