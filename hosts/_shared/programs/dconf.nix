# █▀▄ █▀▀ █▀█ █▄░█ █▀▀ ▀
# █▄▀ █▄▄ █▄█ █░▀█ █▀░ ▄
# -- -- -- -- -- -- -- -

{ config, lib, ... }: {
  programs.dconf = {
    enable = lib.mkDefault config.desktop.enable;  # ! required for gnome apps
  };
}
