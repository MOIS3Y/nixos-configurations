# █▀▀ █▄░█ █▀█ █▀▄▀█ █▀▀   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# █▄█ █░▀█ █▄█ █░▀░█ ██▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.gnome = {
    at-spi2-core.enable = lib.mkDefault config.desktop.enable;
    sushi.enable = lib.mkDefault config.desktop.enable;
    gnome-keyring.enable = lib.mkDefault config.desktop.enable;
    evolution-data-server.enable = lib.mkDefault config.desktop.enable;
    gnome-online-accounts.enable = lib.mkDefault config.desktop.enable;
    localsearch.enable = lib.mkDefault config.desktop.enable;
  };
}
