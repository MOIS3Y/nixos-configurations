# █▀█ █▀█ █ █▄░█ ▀█▀ █▀▀ █▀█ ▄▄ █▀▀ █░█ █▀█ █▀ █▀█ █▀█ ▀
# █▀▀ █▄█ █ █░▀█ ░█░ ██▄ █▀▄ ░░ █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# Configures the global pointer cursor theme and size.

{ config, ... }:
{
  home.pointerCursor = {
    enable = true;
    name = config.desktop.cursor.name;
    package = config.desktop.cursor.package;
    size = 24;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}
