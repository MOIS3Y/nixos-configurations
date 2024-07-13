# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
in {
  options.desktop = with lib; {
    wayland = {
      enable = mkEnableOption "Enable wayland environment";
    };
    xorg = {
      enable = mkEnableOption "Enable x11 environment";
    };
  };
  config = {};
}
