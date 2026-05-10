# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = (
        lib.lists.elem "hyprland" cfg.compositors ->
        !config.services.desktopManager.gnome.enable
      );
      message = ''
        [Configuration Error] Hyprland and GNOME are mutually exclusive!

        Problem detected:
        - Hyprland is requested in `desktop.compositors`.
        - GNOME is enabled via `services.desktopManager.gnome.enable`.

        Required action:
        Disable GNOME to use Hyprland as a standalone compositor.
      '';
    }
  ];
  programs.hyprland = {
    enable = lib.lists.elem "hyprland" cfg.compositors;
    # ? waiting fix uwsm with sddm
    # ? see: https://github.com/Vladimir-csp/uwsm/issues/92
    withUWSM = false;
  };
}
