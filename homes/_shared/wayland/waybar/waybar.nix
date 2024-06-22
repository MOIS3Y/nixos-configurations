# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }:
  let
    bars = import ./bars.nix { inherit config; inherit pkgs; inherit lib; };
    styles = import ./styles.nix { inherit config; inherit pkgs; };
  in {
  options = {
    programs.waybar.excludeWidgets = lib.mkOption {
      default = [];
      type = with lib.types; listOf (enum [
        "battery"
        "group/group-backlight"
        "custom/ddcutil"
      ]);
      description = "Exclude widgets from current bar";
    };
    programs.waybar.ddcutil.busNumber = lib.mkOption {
      default = 6;  # ? my monitor on /sys/bus/i2c/devices/i2c-6 card1-DP-1
      type = lib.types.number;
      description = ''
        The bus number is the DP or HDMI port of the video card 
        to which the monitor is connected
      '';
    };
    programs.waybar.ddcutil.multiplier = lib.mkOption {
      default = 5;
      type = lib.types.enum [ 1 2 3 4 5 6 7 ];
      description = ''
        Required for speed of operation and reduction of imput lag
      '';
    };
    programs.waybar.ddcutil.step = lib.mkOption {
      default = 5;
      type = lib.types.number;
      description = ''
        Steps to increase or decrease brightness
      '';
    };
    programs.waybar.ddcutil.bright = lib.mkOption {
      default = 50;
      type = lib.types.number;
      description = ''
        Quickly set screen brightness to a specified value
      '';
    };
    programs.waybar.ddcutil.dark = lib.mkOption {
      default = 25;
      type = lib.types.number;
      description = ''
        Quickly set screen brightness to a specified value
      '';
    };
  };
  config = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        primaryBar = bars.primary;
      };
      style = styles.primary;
    };
  };
}
