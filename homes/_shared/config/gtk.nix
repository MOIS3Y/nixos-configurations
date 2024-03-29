# █▀▀ ▀█▀ █▄▀ ▀
# █▄█ ░█░ █░█ ▄
# -- -- -- -- -

{ config, pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ 
          "blue" 
          # "flamingo"
          # "green"
          # "lavender"
          # "maroon" 
          # "mauve" 
          # "peach"
          # "pink"
          # "red"
          # "rosewater"
          # "sapphire"
          # "sky"
          # "teal"
          # "yellow"
          ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Tela-circle-blue-dark";
      package = pkgs.tela-circle-icon-theme.override {
        allColorVariants = true;
      };
    };
    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:";
    };
  };
}
