# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: let
  cfg = config.desktop;
in {
  assertions = [
    {
      assertion = config.desktop.desktopManager.gnome.enable ->  
        (config.desktop.xorg.enable && config.desktop.wayland.enable);
      message = ''
        [Conflict Detected] GNOME requires both Xorg and Wayland support!

        Current state:
        • Xorg: ${lib.boolToString config.desktop.xorg.enable}
        • Wayland: ${lib.boolToString config.desktop.wayland.enable}

        Resolution:
        • To use GNOME, enable both protocols:
          `desktop.xorg.enable = true;`
          `desktop.wayland.enable = true;`

        • To keep current protocol configuration, disable GNOME:
          `desktop.desktopManager.gnome.enable = false;`
      '';
    }
  ];
  warnings = [
    (lib.optionalString (
      config.desktop.desktopManager.gnome.enable &&
      cfg.wayland.compositors != []
    ) ''
      WARNING: Detected Wayland compositors while using GNOME:

      [${lib.concatStringsSep ", " cfg.wayland.compositors}]
      
      These will be automatically disabled because:
      - GNOME provides its own Wayland compositor
      - Running multiple compositors causes conflicts in:
        * Session management
        * Services conflicts
        * Display control
      
      To use these compositors instead of GNOME:
      1. Disable GNOME: `desktop.desktopManager.gnome.enable = false`
      2. Keep the compositors list
    '')
    (lib.optionalString (
      config.desktop.desktopManager.gnome.enable &&
      cfg.xorg.windowManagers != []
    ) ''
      WARNING: Detected Xorg window managers while using GNOME:

      [${lib.concatStringsSep ", " cfg.xorg.windowManagers}]
      
      These will be automatically disabled because:
      - GNOME manages its own windows
      - Running additional WMs causes:
        * Window decoration conflicts
        * Services conflicts
      
      To use these window managers instead of GNOME:
      1. Disable GNOME: `desktop.desktopManager.gnome.enable = false`
      2. Keep the window managers list
    '')
  ];

  services.desktopManager.gnome = {
    enable = lib.mkDefault config.desktop.desktopManager.gnome.enable;
  };
}
