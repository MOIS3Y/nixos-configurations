# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{ inputs, config, pkgs, lib, ... }: let
  cfg = config.host.boot;
  theme = inputs.distro-grub-themes.packages.${pkgs.system}."${cfg.grubTheme}-grub-theme";
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
  config = {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
        grub = {
          devices = [ "nodev" ];
          efiSupport = true;
          useOSProber = true;
          configurationLimit = 5;
          gfxmodeEfi = "1920x1080";
          splashImage = "${theme}/splash_image.jpg";
          inherit theme;
        };
      };
      plymouth = {
        enable = true;
        themePackages = [
          pkgs.adi1090x-plymouth-themes
        ];
        theme = "connect";
      };
      kernelParams = [ "quiet" ];
      consoleLogLevel = 3;
    };
  };
}
