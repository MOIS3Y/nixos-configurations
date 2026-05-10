# █▀▄ █ █▀ █▀█ █░░ ▄▀█ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ █ ▄█ █▀▀ █▄▄ █▀█ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, ... }: let
  cfg = config.desktop;
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
];
  services = {
    displayManager = {
      enable = cfg.displayManager.enable;
      gdm = {
        enable = cfg.displayManager.gdm.enable;
      };
    };
  };
}
