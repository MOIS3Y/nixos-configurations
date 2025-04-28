# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: let
  cfg = config.desktop.wayland;
  inherit (config.colorScheme)
    palette;
  inherit (config.desktop)
    apps
    devices
    scripts;
  in {
  wayland.windowManager.hyprland = {
    enable = cfg.enable;
    package = pkgs.hyprland;
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
        border_size = 1;
        no_border_on_floating = false;
        gaps_in = 4;
        gaps_out = 8;
        "col.inactive_border" = "rgba(${palette.base00}ff)";
        "col.active_border" = "rgba(${palette.base0D}ff) rgba(${palette.base0E}ff) 60deg";
        resize_on_border = true;
      };
      #! -- -- -- --  -- -- decoration -- -- -- -- --  #
      decoration = {
        rounding = 6;
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
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
      #! -- -- -- --  -- -- misc -- -- -- -- -- -- - #
      misc = {
        disable_hyprland_logo = true;
        swallow_regex = "^(Alacritty|kitty|org.wezfurlong.wezterm)$";
        vrr = 1;
        
      };
      #! -- -- -- --  -- -- rules -- -- -- -- -- --  #
      windowrulev2 = [
        # tags
        "tag +music, class:^(feishin|io.bassi.Amberol)"
        "tag +music, title:^(.*Yandex Music.*)"
        # default workspace position
        "workspace 1, class:^(firefox)$"
        "workspace 3, class:^(org.telegram.desktop)$"
        "workspace 3, class:^(Mattermost)$"
        "workspace 4, class:^(code-url-handler)$"  # VSCode
        "workspace 6, class:^(zoom)$"
        # default floating
        "float,       class:^(nm-connection-editor)"
        "float,       class:^(.blueman-manager-wrapped)"
        "float,       class:^(zoom)"
        "float,       class:^(org.gnome.Calculator)"
        # disable blur
        "noblur,      class:^(vlc)"
        "noblur,      class:^(zoom)"
        # size
        "size 350 700,class:^(org.gnome.Calculator)"
        # opacity
        "opacity 0.8 override 0.8 override 1.0 override, tag:music"
      ];
      layerrule = [
        # make some windows bg bluring
        "blur,       logout_dialog"  #  wlogout
        "xray 1,     logout_dialog"
        # "blur,       swaync-control-center"
        # "blur,       swaync-notification-window"
        # "ignorezero, swaync-control-center"
        # "ignorezero, swaync-notification-window"
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
        # sound and brightness managment
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
