# █▀▄ █░█ █▄░█ █▀ ▀█▀ ▀
# █▄▀ █▄█ █░▀█ ▄█ ░█░ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.xorg.enable {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = config.gtk.iconTheme.name;
      package = config.gtk.iconTheme.package;
      size = "32x32";
    };
    settings = with config.colorScheme.palette; {
      global =  {
        # Display:
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "25x25";
        scale = 0;
        notification_limit = 0;
        # Progress bar:
        progress_barr = true;
        progress_bar_height = 9;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 8;
        #Preferences:
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 1;
        padding = 10;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 1;
        frame_color = "#${base01}";
        gap_size = 8;
        separator_color = "frame";
        sort = "yes";
        font = "Ubuntu Regular 9";
        line_height = 0;
        markup = "full";
        format = "<span size='x-large' font_desc='monospace 9' weight='bold' foreground='#${base05}'>%a</span>\\n%s\\n%b";
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
        icon_theme = "${config.gtk.iconTheme.name}";
        icon_path = with config.gtk.iconTheme;
          let
            status = "${package}/share/icons/${name}/16/status/";
            devices = "${package}/share/icons/${name}/16/devices/";
          in
          "${status}:${devices}";
        # History:
        sticky_history = "yes";
        history_length = 20;
        # Midc/Adwanced:
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 8;
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
        background = "#${base00}";
        foreground = "#${base05}";
        highlight = "#${base0E}";
        timeout = 10;
      };
      urgency_normal = {
        background = "#${base00}";
        foreground = "#${base05}";
        highlight = "#${base0E}";
        timeout = 10;
      };
      urgency_critical = {
        background = "#${base00}";
        foreground = "#${base05}";
        frame_color = "#${base08}";
        highlight = "#${base0E}";
        timeout = 0;
      };
    };
  };
  #?Add to $PATH, it might call late to show current volume
  home.packages = with config.desktop.scripts.dunst; [
    dunst-volume
    dunst-microphone
    dunst-brightness 
  ];
}
