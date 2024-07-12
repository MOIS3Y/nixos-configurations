# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.host.hardware;
in {
  options.host.hardware = with lib; {
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
      description = "CPU family of motherboard. Allows for addition motherboard i2c support.";
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
    ddcci = mkEnableOption "Enable ddcci support for control external monitors";
  };
  config = with pkgs; with lib; {
    services.hardware.openrgb = mkIf cfg.openRGB {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "intel";
    };
    hardware.bluetooth = mkIf cfg.bluetooth {
      enable = true;
      powerOnBoot = true;
    };
    hardware.graphics = mkIf cfg.graphics {
      enable = true;
      enable32Bit = true;
    };
    # CPU:
    hardware.cpu = mkIf cfg.updateMicrocode {
      intel.updateMicrocode = if cfg.cpu == "intel" then true else false;
      amd.updateMicrocode = if cfg.cpu == "amd" then true else false;
    };
    # GPU:
    boot.extraModprobeConfig = mkIf cfg.gpu ''
      options amdgpu ppfeaturemask=0xFFF7FFFF
    '';
    systemd = mkIf cfg.gpu {
      packages = [ lact ];
      services = {
        # ? daemon required for managment gpu settings
        # ? see: https://github.com/NixOS/nixpkgs/issues/317544
        lactd = {
          enable = true; # this is true by default
          wantedBy = [ "multi-user.target" ]; # auto start at boot time 
        };
      };
    };
    environment.systemPackages = mkIf cfg.gpu [
      amdgpu_top
      lact
      nvtopPackages.amd
    ];
    # DDCCI: 
    boot.extraModulePackages = mkIf cfg.ddcci [ config.boot.kernelPackages.ddcci-driver ]; 
    boot.kernelModules = mkIf cfg.ddcci (
      [ "i2c-dev" "ddcci_backlight" ]
      ++ optionals (cfg.motherboard == "amd") [ "i2c-piix4" ]
      ++ optionals (cfg.motherboard == "intel") [ "i2c-i801" ]
    );
    services.udev.packages = mkIf cfg.ddcci [ ddcutil ]; #! MSI Monitor, Model:G2712
  };
}
