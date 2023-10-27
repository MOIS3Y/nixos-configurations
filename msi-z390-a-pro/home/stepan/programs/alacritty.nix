  # ▄▀█ █░░ ▄▀█ █▀▀ █▀█ █ ▀█▀ ▀█▀ █▄█ ▀
  # █▀█ █▄▄ █▀█ █▄▄ █▀▄ █ ░█░ ░█░ ░█░ ▄
  # -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  programs.alacritty = {
    package = pkgs.alacritty;
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      live_config_reload = true;
      cursor.style = {
        shape = "Underline";
        blinking = "On";
        unfocused_hollow = false;
      };
      window = {
        padding.x = 25;
        padding.y = 25;
        opacity = 0.4;
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
      colors = {
        primary = {
          background = "#11111B";
          foreground = "#CDD6F4";        # text
          dim_foreground = "#CDD6F4";    # text
          bright_foreground = "#CDD6F4"; # text
        };
        cursor = {
          text = "#11111B";   # base
          cursor = "#B4BEFE"; # rosewater
        };
        #.......
        vi_mode_cursor = {
          text = "#11111B";   # base
          cursor = "#B4BEFE"; # lavender
        };
        search = {
          matches = {
            foreground = "#11111B"; # base
            background = "#A6ADC8"; # subtext0
          };
          focused_match = {
            foreground = "#11111B"; # base
            background = "#A6E3A1"; # green
          };
          footer_bar = {
            foreground = "#11111B"; # base
            background = "#A6ADC8"; # subtext0
          };
        };
        hints = {
          start = {
            foreground = "#11111B"; # base
            background = "#F9E2AF"; # yellow
          };
          end = {
            foreground = "#11111B"; # base
            background = "#A6ADC8"; # subtext0
          };
        };
        selection = {
          text = "#11111B";       # base
          background = "#F5E0DC"; # rosewater
        };
        normal = {
          black = "#45475A";   # surface1
          red = "#F38BA8";     # red
          green = "#A6E3A1";   # green
          yellow = "#F9E2AF";  # yellow
          blue = "#89B4FA";    # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5";    # teal
          white = "#BAC2DE";   # subtext1
        };
        bright = {
          black = "#585B70";   # surface2
          red = "#F38BA8";     # red
          green = "#A6E3A1";   # green
          yellow = "#F9E2AF";  # yellow
          blue = "#89B4FA";    # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5";    # teal
          white = "#A6ADC8";   # subtext0
        };
        dim = {
          black = "#45475A";   # surface1
          red = "#F38BA8";     # red
          green = "#A6E3A1";   # green
          yellow = "#F9E2AF";  # yellow
          blue = "#89B4FA";    # blue
          magenta = "#F5C2E7"; # pink
          cyan = "#94E2D5";    # teal
          white = "#BAC2DE";   # subtext1
        };
      };
    };
  };
}
