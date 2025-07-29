# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{ lib, ... }: let 
  inherit (lib)
    mkOption
    types;
in {
  options.host.boot = {
    grubTheme = mkOption {
      type = types.enum [
        "gigabyte"
        "huawei"
        "msi"
        "nixos"
      ];
      default = "nixos";
      description = "Name of grub theme to be used.";
    };
  };
  config = {};
}
