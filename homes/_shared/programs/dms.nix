# █▀▄ █▀▄▀█ █▀ ▀
# █▄▀ █░▀░█ ▄█ ▄
# -- -- -- -- --
# Dank Material Shell (DMS) configuration and theming.

{ config, lib, ... }:
let
  inherit (lib)
    mkIf
    mkDefault
    mkOption
    types
    ;
  cfg = config.programs.dms;
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
  };  config = mkIf cfg.enable {
    programs.dms.theme = mkDefault config.matugen.theme.custom.dms;

    xdg.configFile = {
      "DankMaterialShell/themes/${cfg.theme.id}/theme.json".text = builtins.toJSON cfg.theme;
      "DankMaterialShell/themes/${cfg.theme.id}/preview-dark.svg".source =
        ../../../raw/catppuccino/preview-dark.svg;
      "DankMaterialShell/themes/${cfg.theme.id}/preview-light.svg".source =
        ../../../raw/catppuccino/preview-light.svg;
    };
  };
}
