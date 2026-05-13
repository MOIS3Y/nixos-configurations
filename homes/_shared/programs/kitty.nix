# █▄▀ █ ▀█▀ ▀█▀ █▄█ ▀
# █░█ █ ░█░ ░█░ ░█░ ▄
# -- -- -- -- -- -- -
# Configures the Kitty terminal emulator, including fonts and colors.

{
  config,
  lib,
  ...
}:
let
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
in
{
  programs.kitty = {
    enable = lib.mkDefault config.desktop.enable;
    shellIntegration.enableZshIntegration = false; # fix underline cursor
    settings = {
      # Font:
      font_family = "JetBrains Mono Nerd Font";
      font_size = "11.0";
      bold_font = "auto";
      bold_italic_font = "auto";
      italic_font = "auto";
      disable_ligatures = "never";
      text_composition_strategy = "legacy"; # fix too bold regular font
      # Cursor:
      cursor_blink_interval = "-1";
      cursor_shape = "underline";
      cursor_stop_blinking_after = 0;
      cursor_underline_thickness = "1.0";
      # Scrollback:
      scrollback_lines = 3000;
      touch_scroll_multiplier = "1.0";
      wheel_scroll_multiplier = "5.0";
      # Mouse:
      url_style = "straight";
      # Terminal bell:
      enable_audio_bell = "yes";
      window_alert_on_bell = "yes";
      bell_on_tab = "🔔";
      # SSH:
      allow_remote_control = "no";
      # Window layout:
      window_margin_width = 0;
      window_padding_width = 15;
      inactive_text_alpha = "1.0";
      confirm_os_window_close = 0;
      hide_window_decorations = "no";
      placement_strategy = "center";
      resize_in_steps = "yes";
      # Advanced:
      editor = "nvim";

      # -- [ Manual Colors ] --
      # The basic colors
      background_opacity = "1.0";
      foreground = palette.fg_text;
      background = palette.bg_base;
      selection_foreground = palette.bg_base;
      selection_background = palette.fg_text;
      # Cursor colors
      cursor = palette.fg_text;
      cursor_text_color = palette.black;
      # URL underline color
      url_color = palette.magenta;
      # Tab bar colors
      tab_bar_background = palette.black;
      active_tab_foreground = palette.fg_text;
      active_tab_background = palette.bg_surface;
      inactive_tab_foreground = palette.fg_subtext;
      inactive_tab_background = palette.bg_mantle;
      # The 16 terminal colors
      color0 = palette.black;
      color1 = palette.red;
      color2 = palette.green;
      color3 = palette.yellow;
      color4 = palette.blue;
      color5 = palette.magenta;
      color6 = palette.cyan;
      color7 = palette.white;
      color8 = palette.bright_black;
      color9 = palette.bright_red;
      color10 = palette.bright_green;
      color11 = palette.bright_yellow;
      color12 = palette.bright_blue;
      color13 = palette.bright_magenta;
      color14 = palette.bright_cyan;
      color15 = palette.bright_white;
      # -----------------------
    };
    # -- [ DMS auto config ] --
    # extraConfig = ''
    #   include dank-tabs.conf
    #   include dank-theme.conf
    # '';
    # -------------------------
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
