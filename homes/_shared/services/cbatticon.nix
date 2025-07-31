# █▀▀ █▄▄ ▄▀█ ▀█▀ ▀█▀ █ █▀▀ █▀█ █▄░█ ▀
# █▄▄ █▄█ █▀█ ░█░ ░█░ █ █▄▄ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ lib, osConfig, ... }: {
  services.cbatticon = {
    enable = lib.mkDefault (
      osConfig.services.xserver.windowManager.awesome.enable &&
      !osConfig.services.desktopManager.gnome.enable
    );
    lowLevelPercent = 20;
    criticalLevelPercent = 5;
  };
}
