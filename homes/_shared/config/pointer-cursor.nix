# █▀█ █▀█ █ █▄░█ ▀█▀ █▀▀ █▀█ ▄▄ █▀▀ █░█ █▀█ █▀ █▀█ █▀█ ▀
# █▀▀ █▄█ █ █░▀█ ░█░ ██▄ █▀▄ ░░ █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
    home.pointerCursor = {
      name = "catppuccin-mocha-blue-cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
      x11.defaultCursor = "left_ptr";
  };
}
