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
      name = "Catppuccin-papirus-folders";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "blue";
        flavor = "mocha";  
      };
    };
  };
}
