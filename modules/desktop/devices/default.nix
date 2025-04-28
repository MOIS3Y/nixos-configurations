# █▀▄ █▀▀ █░█ █ █▀▀ █▀▀ █▀ ▀
# █▄▀ ██▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- --

{ lib, ... }: let
  inherit (lib)
    mkOption
    mkEnableOption
    literalExpression
    types;
  in {
  options.desktop.devices = {
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
        };
      });
      description = ''
        Properties of the monitor in the format that Hyprland uses.
        The monitor name can also be used in the configuration of services
        such as Hyprlock and Waybar.
      '';
    };
    keyboard = {
      enable = mkEnableOption "Wether to enable keyboard";
      settings = mkOption {
        type = with types;
          let
            valueType = nullOr (oneOf [
              str
              attrs
              (attrsOf valueType)
            ]) // {
              description = "Attrs with keyboard params";
            };
          in valueType;
        description = ''
          Current keyboard settings.
        '';
        example = literalExpression ''
          {
            name = "keyboard name (can get with hyprctl devices)";
            kb_layout = "us,ru";
            kb_model = "pc104";
            kb_options = "grp:alt_shift_toggle";
          };
        '';
      };
    };
    touchpad = {
      enable = mkEnableOption "Wether to enable touchpad";
      settings = mkOption {
        type = with types;
          let
            valueType = nullOr (oneOf [
              str
              attrs
              (attrsOf valueType)
            ]) // {
              description = "Attrs with touchpad params";
            };
          in valueType;
        description = ''
          Current touchpad settings.
        '';
        example = literalExpression ''
          {
            name = "Touchpad name (can get with hyprctl devices)";
            disable_while_typing = true;
            natural_scroll = true;
            tap-to-click = true;
          };
        '';
      };
    };
    battery = {
      enable = mkEnableOption "Wether to enable battery power management";
    };
    bluetooth = {
      enable = mkEnableOption "Wether to enable bluetooth management";
    };
    lid = {
      enable = mkEnableOption "Wether to enable lid switch";
    };
    ddcci = {
      enable = mkEnableOption "Wether to enable ddcci to manage monitor brightness";
      busNumber = mkOption {
        default = 6;  # ? my monitor on /sys/bus/i2c/devices/i2c-6 card1-DP-1
        type = types.number;
        description = ''
          The bus number is the DP or HDMI port of the video card 
          to which the monitor is connected.
        '';
      };
      multiplier = mkOption {
        default = 5;
        type = types.enum [ 1 2 3 4 5 6 7 ];
        description = ''
          Required for speed of operation and reduction of input lag.
        '';
      };
      step = mkOption {
        default = 5;
        type = types.number;
        description = ''
          Steps to increase or decrease brightness.
        '';
      };
      bright = mkOption {
        default = 50;
        type = types.number;
        description = ''
          Quickly set screen brightness to a specified value.
        '';
      };
      dark = mkOption {
        default = 25;
        type = types.number;
        description = ''
          Quickly set screen brightness to a specified value.
        '';
      };
    };
  };
  config = {};
}