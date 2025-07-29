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
    motherboard = mkOption {
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
    updateMicrocode = mkEnableOption "Update the CPU microcode for current processor.";
    cpu = mkOption {
      type = types.enum [ "intel" "amd" ];
      default = "intel";
      description = "CPU type for microcode update";
    };
    bluetooth = mkOption {
      type = types.bool;
      default = true;
      description = "Enable bluetooth";
    };
    graphics = mkOption {
      type = types.bool;
      default = true;
      description = "Enable openGL";
    };
    gpu = mkEnableOption "Enable GPU services";
    openRGB = mkEnableOption "Enable openRGB";
    coolercontrol = mkEnableOption "Enable coolercontrol";
    ddcci = mkEnableOption "Enable ddcci support for control external monitors";
  };
  config = {};
}