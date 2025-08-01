# █▀▄ █ █▀ █▀█ █░░ ▄▀█ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ █ ▄█ █▀▀ █▄▄ █▀█ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: let
  cfg = config.desktop;
  inherit (config.colorScheme)
    palette;
  in {
  assertions = [
    {
      assertion = config.services.displayManager.enable -> config.desktop.enable;
      message = ''
        [Configuration Error] Incomplete desktop configuration detected!

        Problem:
        - Display Manager enabled (services.displayManager.enable = true)
        - But Desktop environment disabled (desktop.enable = false)

        Required Action:
        1. Recommended: Enable full desktop environment
          `desktop.enable = true;`

        2. Advanced: If you need minimal setup without desktop services:
          `services.displayManager.enable = false;`

        Technical Impact:
        The desktop.enable flag controls critical infrastructure including:
        - NetworkManager integration
        - Power management
        - Bluetooth support
        - Background services

        Warning: Running display manager without desktop services may cause:
        • Unreliable session startup
        • Missing hardware integration
        • Broken system tray functionality
      '';
    }
    {
      assertion = (
        config.services.displayManager.enable -> 
        (cfg.xorg.enable || cfg.wayland.enable)
      );
      message = ''
        [Configuration Error] Neither Xorg nor Wayland is enabled!

        Required Action:
        You must enable at least one graphical protocol:

        1. For Wayland support (recommended for modern setups):
          `desktop.wayland.enable = true;`

        2. For Xorg support (legacy/compatibility):
          `desktop.xorg.enable = true;`

        3. Or enable both for hybrid systems:
          `desktop.wayland.enable = true;`
          `desktop.xorg.enable = true;`

        Note: Most desktop environments require at least one protocol enabled.
              Wayland is preferred for better security and performance.
      '';
    }
    {
      assertion = !(cfg.displayManager.gdm.enable && cfg.displayManager.sddm.enable);
      message = ''
        [Configuration Conflict] Multiple display managers detected!

        Problem:
        - Both GDM and SDDM are currently enabled
        - Only one display manager can be active at a time

        Required Action:
        1. To use GDM, disable SDDM by adding to your configuration:
          `services.displayManager.sddm.enable = false;`
          or via desktop module:
          `desktop.displayManager.sddm.enable = false;`

        2. To use SDDM, disable GDM by adding to your configuration:
          `services.displayManager.gdm.enable = false;`
          or via desktop module:
          `desktop.displayManager.gdm.enable = false;`

        Technical Details:
        - Display managers handle graphical user sessions
        - Running multiple managers causes:
          * Session conflicts
          * Resource competition
          * Unpredictable login behavior
      '';
    }
];
  services = {
    displayManager = {
      enable = cfg.displayManager.enable;
      gdm = {
        enable = cfg.displayManager.gdm.enable;
      };
      sddm = { 
        enable = cfg.displayManager.sddm.enable;
        wayland = {
          enable = cfg.wayland.enable;
        };
        extraPackages = [
          pkgs.libsForQt5.qt5.qtgraphicaleffects
          cfg.cursor.package  #? not working add it in systemPackages
        ];
        autoNumlock = true;
        theme = ''${
          pkgs.extra.sddm-sugar-candy.override {
            settings = {
              Background = "${cfg.assets.images.background}";
              ScreenWidth = "1920";
              ScreenHeight = "1080";
              MainColor = "#${palette.base05}";
              AccentColor = "#${palette.base0D}";
              BackgroundColor = "#${palette.base01}";
              OverrideLoginButtonTextColor = "#${palette.base01}";
              Font = "Ubuntu";
              DateFormat = "dddd, d MMMM yyyy";
              HeaderText = "NixOS";
              FormPosition="center";
              FullBlur=true;
            };
          }
        }'';
        settings = {
          Theme = { CursorTheme = cfg.cursor.name; };
        };
      };
    };
  };
}
