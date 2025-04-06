# █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀ ▀
# █▄█ █▀█ █░▀░█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -

# Module contains options for configuration of the gaming environment
# All options get a value in separate configuration modules
# for a specific host and user
# Depending on the values, the configuration is used in _shared/desktop/games

{ config, pkgs, lib, ... }: let
  inherit (lib)
    mkIf
    mkOption
    mkEnableOption
    literalExpression
    types;
  in {
  options.desktop.games = {
    enable = mkEnableOption "Whether to enable games setup.";
    xpadneo.enable = mkEnableOption "Whether to enable xbox gamepad support.";
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = ''
        List of additional packages that will be installed with steam
        The list specified here will expand the standard list.
        protonup-qt is added by default.
      '';
      example = literalExpression ''
        with pkgs; [
          (lutris.override {
            extraPkgs = pkgs: with pkgs; [
              winePackages.unstableFull
            ];
          })
          bottles
        ];
      '';
    };
    externalStorage = {
      enable = mkEnableOption "Enable external storage";
      storagePath = mkOption {
        type = types.str;
        description = ''
          Path to the block device.
          It will be used by systemd as mounts.what.
        '';
      };
      mountPath = mkOption {
        type = types.str;
        description = ''
          Path to the home directory where the storage will be mounted.
          It will be used by systemd as mounts.where automounts.where.
        '';
      };
    };
  };
  config = {};
}
