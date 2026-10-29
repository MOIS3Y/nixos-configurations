# █▀▄ █▀▄▀█ █▀ ▀
# █▄▀ █░▀░█ ▄█ ▄
# -- -- -- -- --
# Dux Shell (DMS) configuration and theming.

{ config, lib, ... }:
let
  inherit (lib)
    mkIf
    mkDefault
    mkOption
    types
    ;
  cfg = config.programs.dms;
  themePath = "${config.xdg.configHome}/dms/themes/${cfg.theme.id}/theme.json";
in
{
  options.programs.dms = {
    enable = mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable DMS theme generation.";
    };
    theme = mkOption {
      type = types.attrs;
      description = "DMS theme attribute set.";
    };
  };

  config = mkIf cfg.enable {
    programs.dms.theme = mkDefault config.matugen.theme.custom.dms;

    xdg.configFile = {
      "dms/config.d/90-static-theme.json".text = builtins.toJSON {
        currentThemeName = "custom";
        customThemeFile = themePath;
      };
      "dms/themes/${cfg.theme.id}/theme.json".text = builtins.toJSON cfg.theme;
      "dms/themes/${cfg.theme.id}/preview-dark.svg".source =
        ../../../raw/catppuccino/preview-dark.svg;
      "dms/themes/${cfg.theme.id}/preview-light.svg".source =
        ../../../raw/catppuccino/preview-light.svg;
    };
  };
}
