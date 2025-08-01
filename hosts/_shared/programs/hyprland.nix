# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = lib.lists.elem "hyprland" cfg.wayland.compositors -> cfg.wayland.enable;
      message = ''
        [Configuration Error] Wayland must be enabled when using Hyprland!

        Problem detected:
        - Hyprland found in wayland.compositors: 
          [ ${lib.concatStringsSep " " cfg.wayland.compositors} ]
        - But desktop.wayland.enable = ${lib.boolToString cfg.wayland.enable};

        Required action:
        1. Either enable Wayland:
          `desktop.wayland.enable = true;`

        2. Or remove Hyprland from compositors:
          `desktop.wayland.compositors = (
            lib.lists.remove "hyprland" config.desktop.wayland.compositors;
          )`

        Technical note:
        desktop.wayland.enable flag controls
        critical infrastructure required by Hyprland.
      '';
    }
  ];
  programs.hyprland = {
    enable = (
      lib.lists.elem "hyprland" cfg.wayland.compositors &&
      !config.services.desktopManager.gnome.enable
    );
    # ? waiting fix uwsm with sddm
    # ? see: https://github.com/Vladimir-csp/uwsm/issues/92
    withUWSM = false;
  };
}
