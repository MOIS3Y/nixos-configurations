# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

# The module sets values ​​for config.desktop.
# These values ​​are available across both NixOS and HM configurations.
# Options can be overridden or expanded later in the configuration 
# itself individually for each host.
# For example, the desktop.games option has additional options in _shared.

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
  preset = lib.attrsets.attrByPath [ cfg.preset ] "workstation" (
    import ./presets.nix
  );
  inherit (lib)
    mkEnableOption
    mkOption
    literalExpression
    types;
  in {
  imports = [
    ./cursor
  ];
  options.desktop = {
    enable = mkEnableOption "Enable desktop setup";
    preset = mkOption {
      type = types.enum [
        "workstation"
        "laptop"
        # add more enum value here ...
      ];
      # default = 
      description = "Preconfigured desktop setup";
    };
    laptop = {
      enable = mkOption {
        type = types.bool;
        default = preset.laptop.enable;
        description = "Enable laptop setup";
      }; 
    };
    wayland = {
      enable = mkOption {
        type = types.bool;
        default = preset.wayland.enable;
        description = "Enable wayland setup";
      }; 
    };
    xorg = {
      enable = mkOption {
        type = types.bool;
        default = preset.xorg.enable;
        description = "Enable X11 setup";
      }; 
    };
    games = {
      enable = mkOption {
        type = types.bool;
        default = preset.games.enable;
        description = "Enable games setup";
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
        default = preset.devices.monitors;
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
        default = preset.devices.keyboard;
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
