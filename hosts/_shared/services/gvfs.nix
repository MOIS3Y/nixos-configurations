# █▀▀ █░█ █▀▀ █▀ ▀
# █▄█ ▀▄▀ █▀░ ▄█ ▄
# -- -- -- -- -- -

{ config, lib, ... }: {
  services.gvfs = {
    enable = lib.mkDefault config.desktop.enable;
  };
}
