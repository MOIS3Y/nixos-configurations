# ▄▀█ █▀█ █▀█ █▀▀ ▄▀█ █▀█ ▄▀█ █▄░█ █▀▀ █▀▀ ▀
# █▀█ █▀▀ █▀▀ ██▄ █▀█ █▀▄ █▀█ █░▀█ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ inputs, lib, ... }: {
  imports = [
    inputs.matugen-nix.nixosModules.default
    inputs.assets4nix.nixosModules.default
  ];

  matugen = {
    enable = lib.mkDefault true;
    seedColor = lib.mkDefault "#89b4fa"; # Catppuccin Mocha Blue
    mode = lib.mkDefault "dark";

    customColors = {
      # DMS JSON export target:
      # builtins.toJSON config.matugen.theme.custom.dms.${config.matugen.mode}
      dms = {
        dark = {
          name = "Catppuccin Mocha (Shifted)";
          primary = "#89b4fa";
          primaryText = "#11111b";
          primaryContainer = "#89dceb";
          secondary = "#f5c2e7";
          surface = "#11111b"; # Shifted from base (#1e1e2e) to crust
          surfaceText = "#cdd6f4";
          surfaceVariant = "#181825"; # Shifted to mantle
          surfaceVariantText = "#bac2de";
          surfaceTint = "#89b4fa";
          background = "#11111b"; # Shifted to crust
          backgroundText = "#cdd6f4";
          outline = "#45475a"; # surface1
          surfaceContainer = "#181825"; # mantle
          surfaceContainerHigh = "#1e1e2e"; # base
          surfaceContainerHighest = "#313244"; # surface0
          error = "#f38ba8";
          warning = "#fab387";
          info = "#89b4fa";
          matugen_type = "scheme-tonal-spot";
        };
        light = {
          name = "Catppuccin Latte";
          primary = "#1e66f5";
          primaryText = "#eff1f5";
          primaryContainer = "#04a5e5";
          secondary = "#ea76cb";
          surface = "#eff1f5";
          surfaceText = "#4c4f69";
          surfaceVariant = "#dce0e8";
          surfaceVariantText = "#5c5f77";
          surfaceTint = "#1e66f5";
          background = "#eff1f5";
          backgroundText = "#4c4f69";
          outline = "#acb0be";
          surfaceContainer = "#e6e9ef";
          surfaceContainerHigh = "#ccd0da";
          surfaceContainerHighest = "#bcc0cc";
          error = "#d20f39";
          warning = "#fe640b";
          info = "#1e66f5";
          matugen_type = "scheme-tonal-spot";
        };
      };

      # Universal semantic palette for terminals, UIs, and configs
      palette = {
        dark = {
          # Backgrounds (Shifted darker)
          bg_base = "#11111b";        # crust
          bg_mantle = "#181825";      # mantle
          bg_surface = "#1e1e2e";     # base
          bg_surface_alt = "#313244"; # surface0

          # Foregrounds
          fg_text = "#cdd6f4";        # text
          fg_subtext = "#a6adc8";     # subtext0

          # Borders
          border = "#45475a";         # surface1
          border_alt = "#585b70";     # surface2

          # Terminal 16-color palette (Normal)
          black = "#45475a";          # surface1
          red = "#f38ba8";            # red
          green = "#a6e3a1";          # green
          yellow = "#f9e2af";         # yellow
          blue = "#89b4fa";           # blue
          magenta = "#cba6f7";        # mauve
          cyan = "#94e2d5";           # teal
          white = "#bac2de";          # subtext1

          # Terminal 16-color palette (Bright)
          bright_black = "#585b70";   # surface2
          bright_red = "#eba0ac";     # maroon
          bright_green = "#a6e3a1";   # green (reused)
          bright_yellow = "#fab387";  # peach
          bright_blue = "#89b4fa";    # blue (reused)
          bright_magenta = "#f5c2e7"; # pink
          bright_cyan = "#89dceb";    # sky
          bright_white = "#a6adc8";   # subtext0
        };
        light = {
          # Backgrounds
          bg_base = "#eff1f5";        # base
          bg_mantle = "#e6e9ef";      # mantle
          bg_surface = "#dce0e8";     # crust
          bg_surface_alt = "#ccd0da"; # surface0

          # Foregrounds
          fg_text = "#4c4f69";        # text
          fg_subtext = "#6c6f85";     # subtext0

          # Borders
          border = "#bcc0cc";         # surface1
          border_alt = "#acb0be";     # surface2

          # Terminal 16-color palette (Normal)
          black = "#5c5f77";          # subtext1
          red = "#d20f39";            # red
          green = "#40a02b";          # green
          yellow = "#df8e1d";         # yellow
          blue = "#1e66f5";           # blue
          magenta = "#ea76cb";        # pink
          cyan = "#179299";           # teal
          white = "#acb0be";          # surface2

          # Terminal 16-color palette (Bright)
          bright_black = "#6c6f85";   # subtext0
          bright_red = "#e64553";     # maroon
          bright_green = "#40a02b";   # green (reused)
          bright_yellow = "#fe640b";  # peach
          bright_blue = "#1e66f5";    # blue (reused)
          bright_magenta = "#ea76cb"; # pink (reused)
          bright_cyan = "#04a5e5";    # sky
          bright_white = "#bcc0cc";   # surface1
        };
      };
    };
  };
}
