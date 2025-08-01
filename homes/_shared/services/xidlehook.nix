# ▀▄▀ █ █▀▄ █░░ █▀▀ █░█ █▀█ █▀█ █▄▀ ▀
# █░█ █ █▄▀ █▄▄ ██▄ █▀█ █▄█ █▄█ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, lib, osConfig, ... }: let 
  inherit (config.desktop)
    scripts;
in {
  services.xidlehook = {
    enable = lib.mkDefault (
      (osConfig.services.xserver.windowManager.qtile.enable ||
      osConfig.services.xserver.windowManager.awesome.enable) &&
      !osConfig.services.desktopManager.gnome.enable
    );
    detect-sleep = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    environment = {
      PRIMARY_DISPLAY = "$(${scripts.xidlehook.primary-display})";
    };
    timers = [
      {
        delay = 600;
        command = "${scripts.xidlehook.notify}";
      }
      {
        delay = 10;
        command = "${scripts.xidlehook.lock}";
      }
      {
        delay = 60;
        command = "${scripts.xidlehook.suspend}";
      }
    ];
  };
}
