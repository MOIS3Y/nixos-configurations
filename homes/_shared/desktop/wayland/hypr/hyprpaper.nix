# █░█ █▄█ █▀█ █▀█ █▀█ ▄▀█ █▀█ █▀▀ █▀█ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▀▀ █▀█ █▀▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ...}: lib.mkIf config.desktop.wayland.enable {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = with config.desktop.assets.images; {
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
