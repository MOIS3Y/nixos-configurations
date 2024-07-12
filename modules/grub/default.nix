# █▀▀ █▀█ █░█ █▄▄ ▀
# █▄█ █▀▄ █▄█ █▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.host.boot;
in {
  options.host.boot = with lib; {
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
  config = with lib; {
    boot.loader.grub.theme = attrsets.attrByPath [ cfg.grubTheme ] "nixos" (
      import ./themes.nix { inherit pkgs;}
    ); # nixos is a default value to return if the path does not exist in attrset
  };
}
