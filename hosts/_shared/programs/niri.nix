# █▄░█ █ █▀█ █ ▀
# █░▀█ █ █▀▄ █ ▄
# -- -- -- -- --

{ config, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = (
        lib.lists.elem "niri" cfg.wayland.compositors -> cfg.wayland.enable
      );
      message = ''
        [Configuration Error] Wayland must be enabled when using Niri!

        Problem detected:
        - Niri found in wayland.compositors: 
          [ ${lib.concatStringsSep " " cfg.wayland.compositors} ]
        - But desktop.wayland.enable = ${lib.boolToString cfg.wayland.enable};

        Required action:
        1. Either enable Wayland:
          `desktop.wayland.enable = true;`

        2. Or remove Niri from compositors:
          `desktop.wayland.compositors = (
            lib.lists.remove "niri" config.desktop.wayland.compositors;
          )`

        Technical note:
        desktop.wayland.enable flag controls
        critical infrastructure required by Niri.
      '';
    }
  ];
  programs.niri = {
    enable = (
      cfg.wayland.enable &&
      lib.lists.elem "niri" cfg.wayland.compositors &&
      !config.services.desktopManager.gnome.enable
    );
  };
}
