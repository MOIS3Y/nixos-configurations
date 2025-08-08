  # ▄▀█ █░░ ▄▀█ █▀▀ █▀█ █ ▀█▀ ▀█▀ █▄█ ▀
  # █▀█ █▄▄ █▀█ █▄▄ █▀▄ █ ░█░ ░█░ ░█░ ▄
  # -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: {
  programs.alacritty = {
    package = pkgs.alacritty;
    enable = lib.mkDefault config.desktop.enable;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      general = {
        live_config_reload = true;
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
      colors = with config.colorScheme.palette; {
        primary = {
          background = "#${base00}";
          foreground = "#${base05}";
          dim_foreground = "#${base05}";
          bright_foreground = "#${base05}";
        };
        cursor = {
          text = "#${base00}";
          cursor = "#${base05}";
        };
        #.......
        vi_mode_cursor = {
          text = "#${base00}";
          cursor = "#${base05}";
        };
        search = {
          matches = {
            foreground = "#${base00}";
            background = "#${base04}";
          };
          focused_match = {
            foreground = "#${base00}";
            background = "#${base0B}";
          };
          # footer_bar = {
          #   foreground = "#${base00}";
          #   background = "#${base02}";
          # };
        };
        hints = {
          start = {
            foreground = "#${base00}";
            background = "#${base0A}";
          };
          end = {
            foreground = "#${base00}";
            background = "#${base02}";
          };
        };
        selection = {
          text = "#${base00}";
          background = "#${base06}";
        };
        normal = {
          black = "#${base01}";
          red = "#${base08}";
          green = "#${base0B}";
          yellow = "#${base0A}";
          blue = "#${base0D}";
          magenta = "#${base0E}";
          cyan = "#${base0C}";
          white = "#${base06}";
        };
        bright = {
          black = "#${base04}";
          red = "#${base05}";
          green = "#${base0B}";
          yellow = "#${base0A}";
          blue = "#${base0D}";
          magenta = "#${base0E}";
          cyan = "#${base0C}";
          white = "#${base06}";
        };
        dim = {
          black = "#${base01}";
          red = "#${base05}";
          green = "#${base0B}";
          yellow = "#${base0A}";
          blue = "#${base0D}";
          magenta = "#${base0E}";
          cyan = "#${base0C}";
          white = "#${base06}";
        };
      };
    };
  };
}
