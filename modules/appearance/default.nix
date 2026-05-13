# ▄▀█ █▀█ █▀█ █▀▀ ▄▀█ █▀█ ▄▀█ █▄░█ █▀▀ █▀▀ ▀
# █▀█ █▀▀ █▀▀ ██▄ █▀█ █▀▄ █▀█ █░▀█ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ inputs, lib, ... }:
{
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
      # builtins.toJSON config.matugen.theme.custom.dms
      dms = {
        id = "catppuccin-shifted";
        name = "Catppuccin Mocha Shifted";
        version = "1.0.0";
        author = "MOIS3Y";
        description = "Soothing shifted Catppuccin theme with perfect contrast";
        dark = {
          name = "Catppuccin Mocha (Shifted)";
          primary = "#89b4fa";
          primaryText = "#11111b";
          primaryContainer = "#243f75";
          secondary = "#b4befe";
          surface = "#11111b";
          surfaceText = "#cdd6f4";
          surfaceVariant = "#181825";
          surfaceVariantText = "#bac2de";
          surfaceTint = "#29313d";
          background = "#11111b";
          backgroundText = "#cdd6f4";
          outline = "#45475a";
          surfaceContainer = "#181825";
          surfaceContainerHigh = "#1e1e2e";
          surfaceContainerHighest = "#313244";
          error = "#f38ba8";
          warning = "#fab387";
          info = "#89b4fa";
          matugen_type = "scheme-tonal-spot";
        };
        light = {
          name = "Catppuccin Latte (Shifted)";
          primary = "#1e66f5";
          primaryText = "#eff1f5";
          primaryContainer = "#e0e9ff";
          secondary = "#7287fd";
          surface = "#eff1f5";
          surfaceText = "#4c4f69";
          surfaceVariant = "#dce0e8";
          surfaceVariantText = "#5c5f77";
          surfaceTint = "#e0e9ff";
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
        variants = {
          type = "multi";
          defaults = {
            dark = {
              accent = "blue";
              flavor = "mocha";
            };
            light = {
              accent = "blue";
              flavor = "latte";
            };
          };
          flavors = [
            {
              id = "mocha";
              name = "Mocha";
              dark = {
                surface = "#11111b";
                surfaceText = "#cdd6f4";
                surfaceVariant = "#181825";
                surfaceVariantText = "#bac2de";
                background = "#11111b";
                backgroundText = "#cdd6f4";
                outline = "#45475a";
                surfaceContainer = "#181825";
                surfaceContainerHigh = "#1e1e2e";
                surfaceContainerHighest = "#313244";
                error = "#f38ba8";
                warning = "#fab387";
                info = "#89b4fa";
              };
              light = { };
            }
            {
              id = "latte";
              name = "Latte";
              dark = { };
              light = {
                surface = "#eff1f5";
                surfaceText = "#4c4f69";
                surfaceVariant = "#dce0e8";
                surfaceVariantText = "#5c5f77";
                background = "#eff1f5";
                backgroundText = "#4c4f69";
                outline = "#acb0be";
                surfaceContainer = "#e6e9ef";
                surfaceContainerHigh = "#ccd0da";
                surfaceContainerHighest = "#bcc0cc";
                error = "#d20f39";
                warning = "#fe640b";
                info = "#1e66f5";
              };
            }
          ];
          accents = [
            {
              id = "rosewater";
              name = "Rosewater";
              mocha = {
                primary = "#f5e0dc";
                primaryText = "#11111b";
                primaryContainer = "#7d5d56";
                secondary = "#f2cdcd";
                surfaceTint = "#3d3237";
              };
              latte = {
                primary = "#dc8a78";
                primaryText = "#eff1f5";
                primaryContainer = "#f6e7e3";
                secondary = "#dd7878";
                surfaceTint = "#f6e7e3";
              };
            }
            {
              id = "flamingo";
              name = "Flamingo";
              mocha = {
                primary = "#f2cdcd";
                primaryText = "#11111b";
                primaryContainer = "#7a555a";
                secondary = "#f5e0dc";
                surfaceTint = "#3c3134";
              };
              latte = {
                primary = "#dd7878";
                primaryText = "#eff1f5";
                primaryContainer = "#f6e5e5";
                secondary = "#dc8a78";
                surfaceTint = "#f6e5e5";
              };
            }
            {
              id = "pink";
              name = "Pink";
              mocha = {
                primary = "#f5c2e7";
                primaryText = "#11111b";
                primaryContainer = "#7a3f69";
                secondary = "#cba6f7";
                surfaceTint = "#3d2f39";
              };
              latte = {
                primary = "#ea76cb";
                primaryText = "#eff1f5";
                primaryContainer = "#f7d7ee";
                secondary = "#8839ef";
                surfaceTint = "#f7d7ee";
              };
            }
            {
              id = "mauve";
              name = "Mauve";
              mocha = {
                primary = "#cba6f7";
                primaryText = "#11111b";
                primaryContainer = "#55307f";
                secondary = "#b4befe";
                surfaceTint = "#33293f";
              };
              latte = {
                primary = "#8839ef";
                primaryText = "#eff1f5";
                primaryContainer = "#eadcff";
                secondary = "#7287fd";
                surfaceTint = "#eadcff";
              };
            }
            {
              id = "red";
              name = "Red";
              mocha = {
                primary = "#f38ba8";
                primaryText = "#11111b";
                primaryContainer = "#6f2438";
                secondary = "#eba0ac";
                surfaceTint = "#3c2930";
              };
              latte = {
                primary = "#d20f39";
                primaryText = "#eff1f5";
                primaryContainer = "#f6d0d6";
                secondary = "#e64553";
                surfaceTint = "#f6d0d6";
              };
            }
            {
              id = "maroon";
              name = "Maroon";
              mocha = {
                primary = "#eba0ac";
                primaryText = "#11111b";
                primaryContainer = "#6d3641";
                secondary = "#f38ba8";
                surfaceTint = "#3a2c31";
              };
              latte = {
                primary = "#e64553";
                primaryText = "#eff1f5";
                primaryContainer = "#f7d8dc";
                secondary = "#d20f39";
                surfaceTint = "#f7d8dc";
              };
            }
            {
              id = "peach";
              name = "Peach";
              mocha = {
                primary = "#fab387";
                primaryText = "#11111b";
                primaryContainer = "#734226";
                secondary = "#f9e2af";
                surfaceTint = "#3b3028";
              };
              latte = {
                primary = "#fe640b";
                primaryText = "#eff1f5";
                primaryContainer = "#ffe4d5";
                secondary = "#df8e1d";
                surfaceTint = "#ffe4d5";
              };
            }
            {
              id = "yellow";
              name = "Yellow";
              mocha = {
                primary = "#f9e2af";
                primaryText = "#11111b";
                primaryContainer = "#6e5a2f";
                secondary = "#a6e3a1";
                surfaceTint = "#3a362a";
              };
              latte = {
                primary = "#df8e1d";
                primaryText = "#eff1f5";
                primaryContainer = "#fff6d6";
                secondary = "#40a02b";
                surfaceTint = "#fff6d6";
              };
            }
            {
              id = "green";
              name = "Green";
              mocha = {
                primary = "#a6e3a1";
                primaryText = "#11111b";
                primaryContainer = "#2f5f36";
                secondary = "#94e2d5";
                surfaceTint = "#2b382c";
              };
              latte = {
                primary = "#40a02b";
                primaryText = "#eff1f5";
                primaryContainer = "#dff4e0";
                secondary = "#179299";
                surfaceTint = "#dff4e0";
              };
            }
            {
              id = "teal";
              name = "Teal";
              mocha = {
                primary = "#94e2d5";
                primaryText = "#11111b";
                primaryContainer = "#2e5e59";
                secondary = "#89dceb";
                surfaceTint = "#2b3836";
              };
              latte = {
                primary = "#179299";
                primaryText = "#eff1f5";
                primaryContainer = "#daf3f1";
                secondary = "#04a5e5";
                surfaceTint = "#daf3f1";
              };
            }
            {
              id = "sky";
              name = "Sky";
              mocha = {
                primary = "#89dceb";
                primaryText = "#11111b";
                primaryContainer = "#24586a";
                secondary = "#74c7ec";
                surfaceTint = "#29363a";
              };
              latte = {
                primary = "#04a5e5";
                primaryText = "#eff1f5";
                primaryContainer = "#dbf1fb";
                secondary = "#209fb5";
                surfaceTint = "#dbf1fb";
              };
            }
            {
              id = "sapphire";
              name = "Sapphire";
              mocha = {
                primary = "#74c7ec";
                primaryText = "#11111b";
                primaryContainer = "#1f4d6f";
                secondary = "#89b4fa";
                surfaceTint = "#27343c";
              };
              latte = {
                primary = "#209fb5";
                primaryText = "#eff1f5";
                primaryContainer = "#def3f8";
                secondary = "#1e66f5";
                surfaceTint = "#def3f8";
              };
            }
            {
              id = "blue";
              name = "Blue";
              mocha = {
                primary = "#89b4fa";
                primaryText = "#11111b";
                primaryContainer = "#243f75";
                secondary = "#b4befe";
                surfaceTint = "#29313d";
              };
              latte = {
                primary = "#1e66f5";
                primaryText = "#eff1f5";
                primaryContainer = "#e0e9ff";
                secondary = "#7287fd";
                surfaceTint = "#e0e9ff";
              };
            }
            {
              id = "lavender";
              name = "Lavender";
              mocha = {
                primary = "#b4befe";
                primaryText = "#11111b";
                primaryContainer = "#3f4481";
                secondary = "#cba6f7";
                surfaceTint = "#2f3140";
              };
              latte = {
                primary = "#7287fd";
                primaryText = "#eff1f5";
                primaryContainer = "#e5e8ff";
                secondary = "#8839ef";
                surfaceTint = "#e5e8ff";
              };
            }
          ];
        };
      };

      # Universal semantic palette for terminals, UIs, and configs
      palette = {
        dark = {
          # Backgrounds (Shifted darker)
          bg_base = "#11111b"; # crust
          bg_mantle = "#181825"; # mantle
          bg_surface = "#1e1e2e"; # base
          bg_surface_alt = "#313244"; # surface0

          # Foregrounds
          fg_text = "#cdd6f4"; # text
          fg_subtext = "#a6adc8"; # subtext0

          # Borders
          border = "#45475a"; # surface1
          border_alt = "#585b70"; # surface2

          # Terminal 16-color palette (Normal)
          black = "#45475a"; # surface1
          red = "#f38ba8"; # red
          green = "#a6e3a1"; # green
          yellow = "#f9e2af"; # yellow
          blue = "#89b4fa"; # blue
          magenta = "#cba6f7"; # mauve
          cyan = "#94e2d5"; # teal
          white = "#bac2de"; # subtext1

          # Terminal 16-color palette (Bright)
          bright_black = "#585b70"; # surface2
          bright_red = "#eba0ac"; # maroon
          bright_green = "#a6e3a1"; # green (reused)
          bright_yellow = "#fab387"; # peach
          bright_blue = "#89b4fa"; # blue (reused)
          bright_magenta = "#f5c2e7"; # pink
          bright_cyan = "#89dceb"; # sky
          bright_white = "#a6adc8"; # subtext0
        };
        light = {
          # Backgrounds
          bg_base = "#eff1f5"; # base
          bg_mantle = "#e6e9ef"; # mantle
          bg_surface = "#dce0e8"; # crust
          bg_surface_alt = "#ccd0da"; # surface0

          # Foregrounds
          fg_text = "#4c4f69"; # text
          fg_subtext = "#6c6f85"; # subtext0

          # Borders
          border = "#bcc0cc"; # surface1
          border_alt = "#acb0be"; # surface2

          # Terminal 16-color palette (Normal)
          black = "#5c5f77"; # subtext1
          red = "#d20f39"; # red
          green = "#40a02b"; # green
          yellow = "#df8e1d"; # yellow
          blue = "#1e66f5"; # blue
          magenta = "#ea76cb"; # pink
          cyan = "#179299"; # teal
          white = "#acb0be"; # surface2

          # Terminal 16-color palette (Bright)
          bright_black = "#6c6f85"; # subtext0
          bright_red = "#e64553"; # maroon
          bright_green = "#40a02b"; # green (reused)
          bright_yellow = "#fe640b"; # peach
          bright_blue = "#1e66f5"; # blue (reused)
          bright_magenta = "#ea76cb"; # pink (reused)
          bright_cyan = "#04a5e5"; # sky
          bright_white = "#bcc0cc"; # surface1
        };
      };
    };
  };
}
