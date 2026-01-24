# █░█ █▄█ █▀█ █▀█ █▀█ ▄▀█ █▀█ █▀▀ █▀█ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▀▀ █▀█ █▀▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ...}: let
  inherit (config.desktop.assets.images)
    wallpaper;
  in {
  services.hyprpaper = {
    enable = lib.mkDefault config.wayland.windowManager.hyprland.enable;
    package = pkgs.hyprpaper;
    settings = {
      splash = false;
      wallpaper = [
        { 
          monitor = "";  #? empty str means for all monitors
          path = "${wallpaper}";
        }
      ];
    };
  };
}
