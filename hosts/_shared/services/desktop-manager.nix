# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = config.desktop.desktopManager.gnome.enable -> (cfg.compositors == []);
      message = ''
        [Conflict Detected] GNOME and standalone compositors are mutually exclusive!

        Current state:
        • GNOME: enabled
        • Compositors: [ ${lib.concatStringsSep ", " cfg.compositors} ]

        Resolution:
        • To use GNOME, remove all entries from `desktop.compositors`.
        • To use standalone compositors, disable GNOME:
          `desktop.desktopManager.gnome.enable = false;`
      '';
    }
  ];

  services.desktopManager.gnome = {
    enable = lib.mkDefault config.desktop.desktopManager.gnome.enable;
  };
}
