# █░█░█ ▄▀█ █▄█ █▀▀ █ █▀█ █▀▀ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▀░ █ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = (
        lib.lists.elem "wayfire" cfg.wayland.compositors -> cfg.wayland.enable
      );
      message = ''
        [Configuration Error] Wayland must be enabled when using Wayfire!

        Problem detected:
        - Wayfire found in wayland.compositors: 
          [ ${lib.concatStringsSep " " cfg.wayland.compositors} ]
        - But desktop.wayland.enable = ${lib.boolToString cfg.wayland.enable};

        Required action:
        1. Either enable Wayland:
          `desktop.wayland.enable = true;`

        2. Or remove Wayfire from compositors:
          `desktop.wayland.compositors = (
            lib.lists.remove "wayfire" config.desktop.wayland.compositors;
          )`

        Technical note:
        desktop.wayland.enable flag controls
        critical infrastructure required by Wayfire.
      '';
    }
  ];
  programs.wayfire = {
    enable = (
      cfg.wayland.enable &&
      lib.lists.elem "wayfire" cfg.wayland.compositors &&
      !config.services.desktopManager.gnome.enable
    );
    plugins = [
      pkgs.wayfirePlugins.wayfire-plugins-extra
    ];
  };
}
