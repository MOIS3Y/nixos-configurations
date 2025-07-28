# █░█ █▄█ █▀█ █▀█ █▀█ ▄▀█ █▀█ █▀▀ █▀█ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▀▀ █▀█ █▀▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ...}: let
  cfg = config.desktop.wayland;
  inherit (config.desktop.assets.images)
    wallpaper;
  in {
  services.hyprpaper = {
    enable = cfg.enable;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [
        "${wallpaper}"
        # add more here ...
      ];
      wallpaper = [
        ",${wallpaper}"
        # ? above <,> mean for all monitors
      ];
    };
  };
}
