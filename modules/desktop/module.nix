# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

# The module adds a custom desktop option and its sub-options
# to the entire configuration to configure the desktop environment.
# This is necessary to have common values ​​between NixOS and HM
# Option values ​​are specified in submodules with the corresponding host name.
# The server.nix submodule is just a placeholder for devices
# that are of the server type and do not use a desktop environment

{ config, pkgs, lib, host, ... }: {
  options.desktop = with lib; {
    enable = mkEnableOption "Enable desktop setup";
    laptop = {
      enable = mkEnableOption "Enable laptop setup";
    };
    wayland = {
      enable = mkEnableOption "Enable wayland setup";
    };
    xorg = {
      enable = mkEnableOption "Enable x11 setup";
    };
    games = {
      enable = mkEnableOption "Enable games setup";
    };
    devices = {
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
        default = [ ];
        description = ''
          Properties of the monitor in the format that Hyprland uses.
          The monitor name can also be used in the configuration of services
          such as Hyprlock and Waybar.
        '';
      };
      keyboard = mkOption {
        type = with types;
          let
            valueType = nullOr (oneOf [
              str
              attrs
              (attrsOf valueType)
            ]) // {
              description = "Attrs with keybord params";
            };
          in valueType;
        description = ''
          Current keyboard properties.
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
  };
  config = {};
}
