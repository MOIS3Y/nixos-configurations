# █░█ █▄█ █▀█ █▀█ █▀█ ▄▀█ █▀█ █▀▀ █▀█ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▀▀ █▀█ █▀▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ...}: lib.mkIf config.desktop.wayland.enable {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [
        "${config.assets.wallpaper}"
        # add more here ...
      ];
      wallpaper = [
        ",${config.assets.wallpaper}"
        # ? above <,> mean for all monitors
      ];
    };
  };
}
