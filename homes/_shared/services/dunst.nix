# █▀▄ █░█ █▄░█ █▀ ▀█▀ ▀
# █▄▀ █▄█ █░▀█ ▄█ ░█░ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
      size = "32x32";
    };
    settings = {
      global = {
        # Display:
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 0;
        # Progress bar:
        progress_barr = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        #Preferences:
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 1;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 1;
        frame_color = "#89b4fa";
        gap_size = 8;
        separator_color = "frame";
        sort = "yes";
        font = "Inter Regular 9";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        # Icons:
        enable_recursive_icon_lookup = true;
        icon_position = "left";
        icon_theme = "Tela-circle-dark";
        icon_path =
          let
            status = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/16/status/";
            devices = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/16/devices/";
          in
          "${status}:${devices}";
        # History:
        sticky_history = "yes";
        history_length = 20;
        # Midc/Adwanced:
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 18;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        browser = "${pkgs.xdg-utils}/bin/xdg-open";
        mouse_left_click = "close_current, open_url";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      experimental = {
        per_monitor_dpi = false;
      };
      urgency_low = {
        background = "#11111b";
        foreground = "#cdd6f4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#11111b";
        foreground = "#cdd6f4";
        timeout = 10;
      };
      urgency_critical = {
        background = "#11111b";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
        timeout = 0;
      };
    };
  };
}
