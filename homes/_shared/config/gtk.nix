# █▀▀ ▀█▀ █▄▀ ▀
# █▄█ ░█░ █░█ ▄
# -- -- -- -- -
# Configures GTK themes, icons, and fonts.

{ config, pkgs, ... }:
let
  extraCss = ''
    @import url("dank-colors.css");
  '';
in
{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu-classic;
      size = 11;
    };
    gtk3 = {
      inherit extraCss;
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      theme = config.gtk.theme;
      iconTheme = config.gtk.iconTheme;
      inherit extraCss;
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
