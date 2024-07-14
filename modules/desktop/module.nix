# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ config, pkgs, lib, desktop, ... }: {
  options.desktop = with lib; {
    enable = mkOption {
      type = types.bool;
      default = desktop.enable;
      description = "Enable desktop setup";
    };
    laptop = {
      enable = mkOption {
        type = types.bool;
        default = desktop.laptop.enable;
        description = "Enable laptop setup";
      };
    };
    wayland = {
      enable = mkEnableOption "Enable wayland setup";
    };
    xorg = {
      enable = mkEnableOption "Enable x11 setup";
    };
    games = {
      enable = mkEnableOption "Enable games setup";
    };
  };
  config = {};
}
