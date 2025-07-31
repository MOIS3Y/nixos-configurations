# █▀▄ █░░ █▀▀ █▄█ █▄░█ ▄▀█ ▀
# █▄▀ █▄▄ ██▄ ░█░ █░▀█ █▀█ ▄
# -- -- -- -- -- -- -- -- --

{ config, lib, ... }: {
  services.dleyna = {
    enable = lib.mkDefault config.desktop.enable;
  };
}
