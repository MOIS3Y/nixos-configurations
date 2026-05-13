# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ pkgs, lib, ... }: let
  inherit (lib)
    mkEnableOption
    mkOption
    literalExpression
    types;
  in {
  options.desktop = {
    enable = mkEnableOption "Whether to enable desktop setup.";

    desktopManager = {
      gnome.enable = mkEnableOption "Whether to enable GNOME desktop manager";
    };

    displayManager = {
      enable = mkEnableOption ''
        Whether to enable systemd’s display-manager service.
      '';
      gdm.enable = mkEnableOption ''
        Whether to enable GDM, the GNOME display manager.
      '';
      greetd.enable = mkEnableOption ''
        Whether to enable greetd, a minimal and flexible login manager daemon.
      '';
    };

    compositors = mkOption {
      type = types.listOf (types.enum [ "niri" ]);
      default = [ ];
      description = "List of preconfigured compositors";
      example = literalExpression "compositors = [ \"niri\" ];";
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
          description = "Current keyboard settings.";
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
          description = "Current touchpad settings.";
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
      battery.enable = mkEnableOption "Wether to enable battery power management";
      bluetooth.enable = mkEnableOption "Wether to enable bluetooth management";
      lid.enable = mkEnableOption "Wether to enable lid switch";
    };

    cursor = {
      name = mkOption {
        type = types.str;
        default = "catppuccin-mocha-dark-cursors";
        description = "Cursor theme name";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.catppuccin-cursors.mochaDark;
        description = "Cursor theme package";
      };
    };

    games = {
      enable = mkEnableOption "Whether to enable games setup.";
      xpadneo.enable = mkEnableOption "Whether to enable xbox gamepad support.";
      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [ ];
        description = "List of additional packages that will be installed with steam";
        example = literalExpression ''
          with pkgs; [
            (lutris.override {
              extraPkgs = pkgs: with pkgs; [
                winePackages.unstableFull
              ];
            })
            bottles
            protonup-qt
          ];
        '';
      };
      externalStorage = {
        enable = mkEnableOption "Enable external storage";
        storagePath = mkOption {
          type = types.str;
          description = "Path to the block device.";
        };
        mountPath = mkOption {
          type = types.str;
          description = "Path to the home directory where the storage will be mounted.";
        };
      };
    };
  };

  config = {};
}
