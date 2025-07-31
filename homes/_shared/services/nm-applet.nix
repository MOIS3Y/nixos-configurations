# █▄░█ █▀▄▀█ ▄▄ ▄▀█ █▀█ █▀█ █░░ █▀▀ ▀█▀ ▀
# █░▀█ █░▀░█ ░░ █▀█ █▀▀ █▀▀ █▄▄ ██▄ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ lib, osConfig, ... }: {
  services.network-manager-applet = {
    enable = lib.mkDefault (!osConfig.services.desktopManager.gnome.enable);
  };
}
