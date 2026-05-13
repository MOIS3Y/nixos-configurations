# ▄▀█ █░░ ▄▀█ █▀▀ █▀█ █ ▀█▀ ▀█▀ █▄█ ▀
# █▀█ █▄▄ █▀█ █▄▄ █▀▄ █ ░█░ ░█░ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- --
# Configures the Alacritty terminal emulator, including fonts and colors.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
in
{
  programs.alacritty = {
    package = pkgs.alacritty;
    enable = lib.mkDefault config.desktop.enable;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      general = {
        live_config_reload = true;
        # -- [ DMS auto colors ] --
        # import = [
        #   "~/.config/alacritty/dank-theme.toml"
        # ];
        # -------------------------
      };
      cursor = {
        unfocused_hollow = false;
        style = {
          shape = "Underline";
          blinking = "On";
        };
      };
      window = {
        padding.x = 25;
        padding.y = 25;
        opacity = 1.0;
        decorations = "Full";
        title = "Alacritty";
        dynamic_title = true;
      };
      font = {
        size = 11;
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Italic";
        };
      };
      # -- [ Manual Colors ] --
      colors = {
        primary = {
          background = palette.bg_base;
          foreground = palette.fg_text;
          dim_foreground = palette.fg_text;
          bright_foreground = palette.fg_text;
        };
        cursor = {
          text = palette.bg_base;
          cursor = palette.fg_text;
        };
        vi_mode_cursor = {
          text = palette.bg_base;
          cursor = palette.fg_text;
        };
        search = {
          matches = {
            foreground = palette.bg_base;
            background = palette.bright_black;
          };
          focused_match = {
            foreground = palette.bg_base;
            background = palette.green;
          };
        };
        hints = {
          start = {
            foreground = palette.bg_base;
            background = palette.yellow;
          };
          end = {
            foreground = palette.bg_base;
            background = palette.black;
          };
        };
        selection = {
          text = palette.bg_base;
          background = palette.white;
        };
        normal = {
          black = palette.black;
          red = palette.red;
          green = palette.green;
          yellow = palette.yellow;
          blue = palette.blue;
          magenta = palette.magenta;
          cyan = palette.cyan;
          white = palette.white;
        };
        bright = {
          black = palette.bright_black;
          red = palette.bright_red;
          green = palette.bright_green;
          yellow = palette.bright_yellow;
          blue = palette.bright_blue;
          magenta = palette.bright_magenta;
          cyan = palette.bright_cyan;
          white = palette.bright_white;
        };
        dim = {
          black = palette.black;
          red = palette.red;
          green = palette.green;
          yellow = palette.yellow;
          blue = palette.blue;
          magenta = palette.magenta;
          cyan = palette.cyan;
          white = palette.white;
        };
      };
      # -----------------------
    };
  };
}
