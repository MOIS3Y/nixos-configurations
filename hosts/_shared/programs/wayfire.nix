# █░█░█ ▄▀█ █▄█ █▀▀ █ █▀█ █▀▀ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▀░ █ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = (
        lib.lists.elem "wayfire" cfg.compositors ->
        !config.services.desktopManager.gnome.enable
      );
      message = ''
        [Configuration Error] Wayfire and GNOME are mutually exclusive!

        Problem detected:
        - Wayfire is requested in `desktop.compositors`.
        - GNOME is enabled via `services.desktopManager.gnome.enable`.

        Required action:
        Disable GNOME to use Wayfire as a standalone compositor.
      '';
    }
  ];
  programs.wayfire = {
    enable = lib.lists.elem "wayfire" cfg.compositors;
    plugins = [
      pkgs.wayfirePlugins.wayfire-plugins-extra
    ];
  };
}
