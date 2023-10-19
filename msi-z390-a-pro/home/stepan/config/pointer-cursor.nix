{pkgs, ...}: {
    home.pointerCursor = {
      name = "Catppuccin-Mocha-Blue-Cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
  };
}
