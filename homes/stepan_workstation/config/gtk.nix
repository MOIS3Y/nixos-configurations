# █▀▀ ▀█▀ █▄▀ ▀
# █▄█ ░█░ █░█ ▄
# -- -- -- -- -

{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Tela-circle-blue-dark";
      package = pkgs.tela-circle-icon-theme.override {
        allColorVariants = true;
      };
    };
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu_font_family;
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = "menu:";
    };
  };
}
