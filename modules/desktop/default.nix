# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -
# Global configuration options for the desktop setup.

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
        type = types.attrsOf types.attrs;
        default = { };
        description = "Monitor configurations (attrset where key is monitor name)";
      };
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
