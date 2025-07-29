# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.host.hardware;
  inherit (lib)
    mkIf
    optionals;
in {
  services.hardware.openrgb = mkIf cfg.openRGB {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = cfg.motherboard;
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
    packages = [ pkgs.lact ];
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
    pkgs.amdgpu_top
    pkgs.lact
    pkgs.nvtopPackages.amd
  ];
  # DDCCI: 
  boot.extraModulePackages = mkIf cfg.ddcci [ config.boot.kernelPackages.ddcci-driver ]; 
  boot.kernelModules = mkIf cfg.ddcci (
    [ "i2c-dev" "ddcci_backlight" ]
    ++ optionals (cfg.motherboard == "amd") [ "i2c-piix4" ]
    ++ optionals (cfg.motherboard == "intel") [ "i2c-i801" "coretemp" "nct6775" ]
  );
  services.udev.packages = mkIf cfg.ddcci [ pkgs.ddcutil ]; #! MSI Monitor, Model:G2712
  # Fans:
  programs.coolercontrol = mkIf cfg.coolercontrol {
    enable = true;
  };
  # SSD:
  services.fstrim.enable = true; 
}
