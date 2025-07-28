# █▀█ █▀█ █ █▄░█ ▀█▀ █▀▀ █▀█ ▄▄ █▀▀ █░█ █▀█ █▀ █▀█ █▀█ ▀
# █▀▀ █▄█ █ █░▀█ ░█░ ██▄ █▀▄ ░░ █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  home.pointerCursor = {
    name = config.desktop.cursor.name;
    package = config.desktop.cursor.package;
    size = 24;
    gtk.enable = true;
    x11 = lib.mkIf config.desktop.xorg.enable {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}
