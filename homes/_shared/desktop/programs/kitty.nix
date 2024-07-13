# █▄▀ █ ▀█▀ ▀█▀ █▄█ ▀
# █░█ █ ░█░ ░█░ ░█░ ▄
# -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = false;  # fix underline cursor
    settings = with config.colorScheme.palette; {
      # Font:
      font_family = "JetBrains Mono Nerd Font";
      font_size = "11.0";
      bold_font = "auto";
      bold_italic_font = "auto";
      italic_font = "auto";
      disable_ligatures = "never";
      text_composition_strategy="legacy";  # fix too bold regular font
      # Cursor:
      cursor_blink_interval = "-1";
      cursor_shape = "underline";
      cursor_stop_blinking_after = 0;
      cursor_underline_thickness = "1.0";
      # Scrollback:
      scrollback_lines = 3000;
      scrollback_indicator_opacity = "0.4";
      touch_scroll_multiplier = "1.0";
      wheel_scroll_multiplier = "5.0";
      # Mouse:
      url_style = "straight";
      # Terminal bell:
      enable_audio_bell = "yes";
      window_alert_on_bell = "yes";
      bell_on_tab = "🔔";
      # SSH:
      share_connections = "no";
      remote_kitty = "no";
      delegate = "ssh";  # fix remote zsh
      # Tab bar:
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 2;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      # Window layout:
      window_margin_width = 0;
      window_padding_width = 15;      
      inactive_text_alpha = "1.0";
      confirm_os_window_close = 0;
      hide_window_decorations = "titlebar-only";
      placement_strategy = "center";
      resize_in_steps = "yes";
      # The basic colors
      background_opacity = "0.8";
      foreground = "#${base05}";
      background = "#${base00}";
      selection_foreground = "#${base00}";
      selection_background = "#${base05}";
      # Cursor colors
      cursor = "#${base05}";
      cursor_text_color = "#${base01}";
      # URL underline color
      url_color = "#${base0E}";
      # Tab bar colors
      tab_bar_background = "#${base01}";
      active_tab_foreground = "#${base05}";
      active_tab_background = "#${base03}";
      inactive_tab_foreground = "#${base04}";
      inactive_tab_background = "#${base02}";
      # The 16 terminal colors
      color0 = "#${base01}";
      color1 = "#${base08}";
      color2 = "#${base0B}";
      color3 = "#${base0A}";
      color4 = "#${base0D}";
      color5 = "#${base0E}";
      color6 = "#${base0C}";
      color7 = "#${base06}";
      color8 = "#${base04}";
      color9 = "#${base08}";
      color10 = "#${base0B}";
      color11 = "#${base0A}";
      color12 = "#${base0D}";
      color13 = "#${base0E}";
      color14 = "#${base0C}";
      color15 = "#${base06}";
      # Advanced:
      editor = "nvim";
    };
    keybindings = {
      # Clipboard:
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+c" = "copy_to_clipboard";
      "shift+insert" = "paste_from_selection";
      # Scroll:
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";
      # Windows:
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+w" = "close_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";
      # Tabs:
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";
      # Font:
      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+shift+f6" = "set_font_size 16.0";
    };
  };
}
