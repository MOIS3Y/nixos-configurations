# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
in {
  options.desktop = with lib; {
    wayland = {
      enable = mkEnableOption "Enable wayland setup";
    };
    xorg = {
      enable = mkEnableOption "Enable x11 setup";
    };
    laptop = {
      enable = mkEnableOption "Enable laptop setup";
    };
    games = {
      enable = mkEnableOption "Enable games setup";
    };
  };
  config = {};
}
