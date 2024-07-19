# █▀█ █▀█ █ █▄░█ ▀█▀ █▀▀ █▀█ ▄▄ █▀▀ █░█ █▀█ █▀ █▀█ █▀█ ▀
# █▀▀ █▄█ █ █░▀█ ░█░ ██▄ █▀▄ ░░ █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: with lib; {
  home.pointerCursor = with config.desktop; {
    name = cursor.name;
    package = cursor.package;
    size = 24;
    gtk.enable = true;
    x11 = mkIf xorg.enable {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}
