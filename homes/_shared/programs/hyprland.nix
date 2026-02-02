# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, osConfig, ... }: let
  inherit (config.colorScheme)
    palette;
  inherit (config.desktop)
    apps
    devices
    scripts;
  in {
  wayland.windowManager.hyprland = {
    enable = osConfig.programs.hyprland.enable;
    package = pkgs.hyprland;
    systemd.enable = !osConfig.programs.hyprland.withUWSM;
    plugins = [
      pkgs.hyprlandPlugins.hyprsplit
      pkgs.hyprlandPlugins.hyprexpo
    ];
    xwayland.enable = true;
    settings = {
      #! -- -- -- -- -- -- autostart -- -- -- -- -- -- #
      exec-once = "${scripts.hyprland.startup}";
      #! -- -- -- -- -- -- modifiers -- -- -- -- -- -- #
      "$mod" = "SUPER";
      #! -- -- -- --  -- -- apps -- -- -- -- -- -- --  #
      "$terminal" = "${apps.terminal}";
      "$spare-terminal" = "${apps.spare-terminal}";
      "$launcher" = "${scripts.hyprland.launcher-toggle}";
      "$browser" = "${apps.browser}";
      "$filemanager" = "${apps.filemanager}";
      "$visual-text-editor" = "${apps.visual-text-editor}";
      "$screenshot" = "${scripts.hyprland.screenshot}";
      "$lockscreen" = "${apps.lockscreen}";
      #! -- -- -- --  -- -- environment -- -- -- -- -- #
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"  # ? If your cursor becomes invisible
        "NIXOS_OZONE_WL,1"           # ? Hint electron apps to use wayland
        "XCURSOR_SIZE,26"
        "QT_STYLE_OVERRIDE,kvantum"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "SSH_AUTH_SOCK,$XDG_RUNTIME_DIR/gcr/ssh" # ? fix gcr-ssh-agent
      ];
      #! -- -- -- --  -- -- monitors -- -- -- -- -- -- #
      # the map function will generate a list of monitors
      # which will be taken from config.desktop.devices.monitors
      # the function is enclosed in parentheses to indicate currying.
      # after it works, a value for an undefined monitor with automatic
      # parameters will be added to the fig list,
      # which will be configured by Hyprland
      monitor = (map (m:
        let
          resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
          position = "${toString m.x}x${toString m.y}";
        in
          "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}"
        )
        (devices.monitors)) ++ [ ",preferred,auto,1" ];
      #! -- -- -- --  -- -- workspace -- -- -- -- -- -- #
      # Currently using the hyprsplit plugin
      # I don't set any specific behavior for specific workspaces,
      # they are all configured the same
      # workspace = [ ];
      #! -- -- -- --  -- -- general -- -- -- -- -- --  #
      general = {
        border_size = 2;
        gaps_in = 4;
        gaps_out = 8;
        "col.inactive_border" = "rgba(${palette.base00}ff)";
        "col.active_border" = "rgba(${palette.base0D}ff) rgba(${palette.base0E}ff) 60deg";
        resize_on_border = true;
      };
      #! -- -- -- --  -- -- decoration -- -- -- -- --  #
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 16;
          passes = 2; # higher then 1 expensive for GPU
          xray = false;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };
      #! -- -- -- --  -- -- input -- -- -- -- -- -- #
      input = {
        kb_layout = devices.keyboard.settings.kb_layout;
        kb_model = devices.keyboard.settings.kb_model;
        kb_options = devices.keyboard.settings.kb_options;
        numlock_by_default = true;
        follow_mouse = 1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = true;
        };
      };
      #! -- -- -- --  -- -- gestures -- -- -- -- -- -- #
      gesture = [
        "3, horizontal, workspace"
      ];
      #! -- -- -- --  -- -- misc -- -- -- -- -- -- - #
      misc = {
        disable_hyprland_logo = true;
        swallow_regex = "^(Alacritty|kitty|org.wezfurlong.wezterm)$";
        vrr = 1;

      };
      #! -- -- -- --  -- -- rules -- -- -- -- -- --  #
      windowrule = [
        # tags
        "tag +music, match:class ^(feishin|io.bassi.Amberol)"
        "tag +music, match:title ^(.*Yandex Music.*)"
        "tag +term, match:class ^(kitty|Alacritty|org.wezfurlong.wezterm)"

        # default workspace position
        "workspace 1, match:class ^(firefox)$"
        "workspace 3, match:class ^(org.telegram.desktop)$"
        "workspace 3, match:class ^(Mattermost)$"
        "workspace 4, match:class ^(code-url-handler)$"  # VSCode

        # default floating
        {
          name = "zoom_rules";
          "match:class" = "^(zoom)$";
          workspace = 6;
          float = true;
          no_blur = "on";
        }
        {
          name = "float_nm";
          "match:class" = "^(nm-connection-editor)";
          float = true;
        }
        {
          name = "float_blueman";
          "match:class" = "^(.blueman-manager-wrapped)";
          float = true;
        }
        {
          name = "float_calc";
          "match:class" = "^(org.gnome.Calculator)";
          float = true;
        }
        # force disable blur
        {
          name = "noblur_vlc";
          "match:class" = "^(vlc)";
          no_blur = "on";
        }
        # dim around rules
        {
          name = "zenity_rules";
          "match:class" = "^(zenity)$";
          dim_around = "on";
          rounding = 16;
          pin = "on";
        }
        {
          name = "nm_connection_rules";
          "match:class" = "^(nm-connection-editor)$";
          dim_around = "on";
        }
        {
          name = "blueman_rules";
          "match:class" = "^(.blueman-manager-wrapped)$";
          dim_around = "on";
        }
        {
          name = "calculator_rules";
          "match:class" = "^(org.gnome.Calculator)$";
          size = "380 700";
          pin = "on";
        }
        # opacity
        "opacity 0.8 override 0.8 override 1.0 override, match:tag music"
        "opacity 0.8 override 0.8, match:tag term"
      ];
      layerrule = [
        {
          name = "logout_dialog_rule";
          animation = "slide top";
          blur = "on";
          xray = 1;
          "match:namespace" = "logout_dialog";
        }
        {
          name = "swaync_notification_rule";
          animation = "slide top";
          "match:namespace" = "swaync-notification-window";
        }
        {
          name = "swaync_control_rule";
          animation = "slide right";
          dim_around = "on";
          "match:namespace" = "swaync-control-center";
        }
        {
          name = "wofi_rule";
          animation = "slide down";
          dim_around = "on";
          "match:namespace" = "wofi";
        }
      ];
      #! -- -- -- -- -- keybindings -- -- -- -- -- #
      bind = let
        # first monitor in the list is primary by default:
        # ! broken see: https://github.com/hyprwm/Hyprland/issues/7055
        # pm = builtins.elemAt devices.monitors 0;

        # resolution = "${toString pm.width}x${toString pm.height}@${toString pm.refreshRate}";
        # position = "${toString pm.x}x${toString pm.y}";
      in [
        # ------------ #
        #  - GENERAL - #
        # ------------ #
        "CTRL ALT, L, exec, $lockscreen"
        # ------------ #
        #  - WINDOWS - #
        # ------------ #
        "$mod, w,   killactive"
        "$mod, TAB, togglefloating"
        "$mod  SHIFT, TAB, fullscreen"
        # move focus with mod
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        # move focus to urgent window
        "$mod, u, focusurgentorlast"
        # move focus to next window
        "$mod, space, cyclenext"
        # move window position
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"
        # resize active window
        "$mod CTRL,  h, resizeactive, -20 0"
        "$mod CTRL,  j, resizeactive, 0 20"
        "$mod CTRL,  k, resizeactive, 0 -20"
        "$mod CTRL,  l, resizeactive, 20 0"
        # scratchpad
        "$mod SHIFT, S, movetoworkspacesilent, special:magic"
        "$mod, S, togglespecialworkspace, magic"
        # ? i think it's broken (not working since v0.53.1)
        # https://wiki.hypr.land/Configuring/Uncommon-tips--tricks/
        # "$mod, S, togglespecialworkspace, magic"
        # "$mod, S, movetoworkspace, +0"
        # "$mod, S, togglespecialworkspace, magic"
        # "$mod, S, movetoworkspace, special:magic"
        # "$mod, S, togglespecialworkspace, magic"

        # hyprsplit:
        "$mod, G, split:grabroguewindows"
        # ---------- #
        #  - APPS -  #
        # ---------- #
        "$mod, RETURN, exec, $terminal"
        "$mod, t,      exec, $spare-terminal"
        "$mod, m,      exec, $launcher"
        "$mod, b,      exec, $browser"
        "$mod, f,      exec, $filemanager"
        "$mod, v,      exec, $visual-text-editor"
        ",     Print,  exec, $screenshot"
        # --------------- #
        #  - WORKSPACES - #
        # --------------- #
        # scroll through existing workspaces with $mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up,   workspace, e-1"
        # --------------- #
        #  - SWITCHES -   #
        # --------------- #
        # ! broken see: https://github.com/hyprwm/Hyprland/issues/7055
        # '',switch:on:Lid Switch,exec,hyprctl keyword monitor "${pm.name},disable"''
        # '',switch:off:Lid Switch,exec,hyprctl keyword monitor "${pm.name},${resolution},${position},1"''
      ]
      ++ (
        # ----------------- #
        #  - WORKSPACES -   #
        # ----------------- #
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              # Default:
              # "$mod,        ${ws}, focusworkspaceoncurrentmonitor, ${toString (x + 1)}"
              # "$mod  SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              # Hyprsplit:
              "$mod,        ${ws}, split:workspace,       ${toString (x + 1)}"
              "$mod  SHIFT, ${ws}, split:movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
      bindr = [
        # ----------------- #
        #  - WORKSPACES -   #
        # ----------------- #
        # Hyprexpo:
        "$mod, SUPER_L, hyprexpo:expo, toggle"
      ];
      bindm = [
        # ------------ #
        #  - WINDOWS - #
        # ------------ #
        # move and resize window
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindle = [
        # --------------- #
        #  - HARDWARE -   #
        # --------------- #
        # sound and brightness management
        ",XF86MonBrightnessUp,   exec, ${scripts.hyprland.brightness-up}"
        ",XF86MonBrightnessDown, exec, ${scripts.hyprland.brightness-down}"
        ",XF86AudioRaiseVolume,  exec, ${scripts.hyprland.volume-up}"
        ",XF86AudioLowerVolume,  exec, ${scripts.hyprland.volume-down}"
        ",XF86AudioMute,         exec, ${scripts.hyprland.volume-mute}"
        ",XF86AudioMicMute,      exec, ${scripts.hyprland.mic-mute}"
      ];
      #! -- -- -- -- -- xwayland -- -- -- -- -- #
      xwayland = {
        force_zero_scaling = true;
      };
    };
    #! -- -- -- -- -- extra config -- -- -- -- #
    extraConfig = ''
      plugin {
        # ? https://github.com/shezdy/hyprsplit/blob/main/README.md
        hyprsplit {
          num_workspaces = 10
        }
        # ? https://github.com/hyprwm/hyprland-plugins/tree/main/hyprexpo#readme
        hyprexpo {
          columns = 3
          gap_size = 10
          bg_col = rgb(${palette.base01})
          workspace_method = center current
          enable_gesture = true
          gesture_fingers = 3
          gesture_distance = 300
          gesture_positive = true
        }
      }
    '';
  };
}
