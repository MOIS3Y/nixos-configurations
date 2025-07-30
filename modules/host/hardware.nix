# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: let
  inherit (lib)
    mkOption
    mkEnableOption
    types
    literalMD;
in {
  options.host.hardware = {
    motherboard = {
      cpu = mkOption {
        type = types.nullOr (types.enum [ "amd" "intel" ]);
        default = if config.hardware.cpu.intel.updateMicrocode then "intel"
          else if config.hardware.cpu.amd.updateMicrocode then "amd"
          else null;
        defaultText = literalMD ''
          if config.hardware.cpu.intel.updateMicrocode then "intel"
          else if config.hardware.cpu.amd.updateMicrocode then "amd"
          else null;
        '';
        description = ''
          CPU family of motherboard.
          Allows for addition motherboard i2c support.
        '';
      };
    };
    bluetooth = {
      enable = mkEnableOption "Whether to enable bluetooth services";
    };
    gpu = {
      enable = mkEnableOption "Whether to enable GPU services";
    };
    graphics = {
      enable = mkEnableOption "Whether to enable OpenGL";
    };
    openRGB = {
      enable = mkEnableOption "Whether to enable openRGB service";
    };
    coolercontrol= {
      enable = mkEnableOption "Whether to enable coolercontrol program";
    };
    ddcci = {
      enable = mkEnableOption "Whether to enable ddcci for external monitors";
    };
  };
  config = {};
}