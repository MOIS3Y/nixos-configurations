# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      #! -- -- -- -- -- -- autostart -- -- -- -- -- -- #
      exec-once = "${config.apps.scripts.hyprland.startup}";
      #! -- -- -- -- -- -- modifiers -- -- -- -- -- -- #
      "$mod" = "SUPER";
      #! -- -- -- --  -- -- apps -- -- -- -- -- -- --  #
      "$terminal" = "${config.apps.terminal}";
      "$launcher" = "${config.apps.scripts.hyprland.launcher-toggle}";
      "$browser" = "${config.apps.browser}";
      "$filemanager" = "${config.apps.filemanager}";
      "$visual-text-editor" = "${config.apps.visual-text-editor}";
      "$screenshot" = "${config.apps.scripts.hyprland.screenshot}";
      "$lockscreen" = "${config.apps.lockscreen}";
      #! -- -- -- --  -- -- environment -- -- -- -- -- #
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"  # ? If your cursor becomes invisible
        "NIXOS_OZONE_WL,1"           # ? Hint electron apps to use wayland
        "XCURSOR_SIZE,26"
      ];
      #! -- -- -- --  -- -- monitors -- -- -- -- -- -- #
      monitor = [
        "DP-1,1920x1080@144,0x0,1"
        ",preferred,auto,1"
      ];
      #! -- -- -- --  -- -- workspace -- -- -- -- -- -- #
      workspace = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9,monitor:HDMI-A-1"
        "10,monitor:HDMI-A-1"
      ];
      #! -- -- -- --  -- -- general -- -- -- -- -- --  #
      general = with config.colorScheme.palette; {
        border_size = 1;
        no_border_on_floating = false;
        gaps_in = 4;
        gaps_out = 8;
        "col.inactive_border" = "rgba(${base00}ff)";
        "col.active_border" = "rgba(${base0D}ff) rgba(${base0E}ff) 60deg";
        resize_on_border = true;
      };
      #! -- -- -- --  -- -- decoration -- -- -- -- --  #
      decoration = {
        rounding = 6;
        blur = {
          enabled = true;
          size = 16;
          passes = 2; # higher then 1 expensive for GPU
          xray = true;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };
      #! -- -- -- --  -- -- input -- -- -- -- -- -- #
      input = {
        kb_layout = "us,ru";
        kb_model = "pc104";
        kb_options = "grp:alt_shift_toggle";
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
        swallow_regex = "^(org.wezfurlong.wezterm)$";
        vrr = 1;
        
      };
      #! -- -- -- --  -- -- rules -- -- -- -- -- --  #
      windowrulev2 = [
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
      ];
      layerrule = [
        # make some windows bg bluring
        "blur,            logout_dialog"  #  wlogout
        # "blur,            swaync-control-center"
        # "blur,            swaync-notification-window"
        # "ignorezero,      swaync-control-center"
        # "ignorezero,      swaync-notification-window"
      ];
      #! -- -- -- -- -- keybindings -- -- -- -- -- #
      bind = with config.apps.scripts.hyprland; [
          # ------------ #
          #  - GENERAL - #
          # ------------ #
          "CTRL ALT, L, exec, $lockscreen"
          # ------------ #
          #  - WINDOWS - #
          # ------------ # 
          "$mod, w,   killactive"
          "$mod, TAB, togglefloating"
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
          # ---------- #
          #  - APPS -  #
          # ---------- # 
          "$mod, RETURN, exec, $terminal"
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
          #  - HARDWARE -   #
          # --------------- #
          # sound and brightness managment
          ",XF86MonBrightnessUp,   exec, ${brightness-up}"
          ",XF86MonBrightnessDown, exec, ${brightness-down}"
          ",XF86AudioRaiseVolume,  exec, ${volume-up}"
          ",XF86AudioLowerVolume,  exec, ${volume-down}"
          ",XF86AudioMute,         exec, ${volume-mute}"
          ",XF86AudioMicMute,      exec, ${mic-mute}"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod,        ${ws}, workspace,       ${toString (x + 1)}"
                "$mod  SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      bindm = [
        # ------------ #
        #  - WINDOWS - #
        # ------------ # 
        # move and resize window
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      #! -- -- -- -- -- xwayland -- -- -- -- -- #
      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
