# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }:
  let
    hyprScreenshot = with pkgs; writeShellScriptBin "hypr-screenshot" ''
      ${grim}/bin/grim -g "$(${slurp}/bin/slurp -w 0)" - | ${swappy}/bin/swappy -f -
    '';
    startupScript = with pkgs; writeShellScriptBin "hypr-startup" ''
      ${waybar}/bin/waybar &
      # ? now they start by systemd modules (HM-modules)
      # ${networkmanagerapplet}/bin/nm-applet &
      # ${blueman}/bin/blueman-applet &
    '';
    wofi = "${pkgs.wofi}/bin/wofi";
    wofi-toggle = with pkgs; writeShellScript "wofi-toggle" ''
      pgrep wofi >/dev/null 2>&1 && pkill wofi || ${wofi} --show drun
    '';
  in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      #! -- -- -- -- -- -- autostart -- -- -- -- -- -- #
      exec-once = "${startupScript}/bin/hypr-startup";
      #! -- -- -- -- -- -- modifiers -- -- -- -- -- -- #
      "$mod" = "SUPER";
      #! -- -- -- --  -- -- apps -- -- -- -- -- -- --  #
      "$terminal" = "${pkgs.wezterm}/bin/wezterm";
      "$launcher" = "${wofi-toggle}";
      "$browser" = "${pkgs.firefox}/bin/firefox";
      "$filebrowser" = "${pkgs.wezterm}/bin/wezterm -e ${pkgs.lf}/bin/lf";
      "$vscode" = "${pkgs.vscode}/bin/code";
      "$screenshot" = "${hyprScreenshot}/bin/hypr-screenshot";
      "$lockscreen" = "${pkgs.swaylock-effects}/bin/swaylock";
      #! -- -- -- --  -- -- environment -- -- -- -- -- #
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"  # ? If your cursor becomes invisible
        "NIXOS_OZONE_WL,1"           # ? Hint electron apps to use wayland
      ];
      #! -- -- -- --  -- -- monitors -- -- -- -- -- -- #
      monitor = [
        "DP-1,1920x1080@144,0x0,1"
        ",preferred,auto,1"
      ];
      #! -- -- -- --  -- -- general -- -- -- -- -- --  #
      general = {
        border_size = 1;
        no_border_on_floating = false;
        gaps_in = 4;
        gaps_out = 8;
        "col.inactive_border" = "rgba(11111bff)";
        "col.active_border" = "rgba(89b4faff) rgba(cba6f7ff) 60deg";
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
      #! -- -- -- --  -- -- misc -- -- -- -- -- -- - #
      misc = {
        disable_hyprland_logo = false;
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
        # disable blur
        "noblur,      class:^(vlc)"
        "noblur,      class:^(zoom)"
      ];
      layerrule = [
        # make some windows bg bluring
        "blur, logout_dialog"  #  wlogout
        # "blur, ^(swaync-control-center)$"
        # "ignorealpha 0.5, ^(swaync-control-center)$"

        "blur,            swaync-control-center"
        "blur,            swaync-notification-window"
        "ignorezero,      swaync-control-center"
        "ignorezero,      swaync-notification-window"
        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];
      #! -- -- -- -- -- keybindings -- -- -- -- -- #
      bind = [
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
          "$mod, f,      exec, $filebrowser"
          "$mod, v,      exec, $vscode"
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
          # sound and brightness managment (see dunst.nix - scripts there) 
          ",XF86MonBrightnessUp,   exec, dunst-brightness set +5%"
          ",XF86MonBrightnessDown, exec, dunst-brightness set 5%-"
          ",XF86AudioRaiseVolume,  exec, dunst-volume -i 5"
          ",XF86AudioLowerVolume,  exec, dunst-volume -d 5"
          ",XF86AudioMute,         exec, dunst-volume -t"
          ",XF86AudioMicMute,      exec, dunst-microphone -t"
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
    };
  };
}
