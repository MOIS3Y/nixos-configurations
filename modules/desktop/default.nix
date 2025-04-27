# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

# The module sets values ​​for config.desktop.
# These values ​​are available across both NixOS and HM configurations.
# Options can be overridden or expanded later in the configuration 
# itself individually for each host.

{ lib, ... }: let
  inherit (lib)
    mkEnableOption
    mkOption
    literalExpression
    types;
  in {
  imports = [
    ./apps
    ./assets
    ./cursor
    ./games
    ./scripts
    ./utils
  ];
  options.desktop = {
    enable = mkEnableOption "Whether to enable desktop setup.";
    laptop = {
      enable = mkOption {
        type = types.bool;
        description = "Whether to enable laptop setup.";
      }; 
    };
    wayland = {
      enable = mkOption {
        type = types.bool;
        description = "Whether to enable wayland setup.";
      }; 
    };
    xorg = {
      enable = mkOption {
        type = types.bool;
        description = "Whether to enable X11 setup.";
      }; 
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
              description = "Attrs with keyboard params";
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
