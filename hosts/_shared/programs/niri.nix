# █▄░█ █ █▀█ █ ▀
# █░▀█ █ █▀▄ █ ▄
# -- -- -- -- --

{ config, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = (
        lib.lists.elem "niri" cfg.compositors ->
        !config.services.desktopManager.gnome.enable
      );
      message = ''
        [Configuration Error] Niri and GNOME are mutually exclusive!

        Problem detected:
        - Niri is requested in `desktop.compositors`.
        - GNOME is enabled via `services.desktopManager.gnome.enable`.

        Required action:
        Disable GNOME to use Niri as a standalone compositor.
      '';
    }
  ];
  programs.niri = {
    enable = lib.lists.elem "niri" cfg.compositors;
  };
}
