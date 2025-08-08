# █░█░█ ▄▀█ █▄█ █▀▀ █ █▀█ █▀▀ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▀░ █ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --

#! Wayfire doesn't work properly right now on current configuration (WIP)

# TODO: set colors (only RGB 0->1 support so weird)
# TODO: shell bar needed (waybar maybe?)
# TODO: tiling feature
# TODO: idle
# TODO: fix terminal decorations

{ config, lib, osConfig, ... }: let
  inherit (config.desktop)
    apps
    devices;
in {
  wayland.windowManager.wayfire = {
    enable = osConfig.programs.wayfire.enable;
    package = null;  # ? use the NixOS wayfire module to install wayfire
    systemd = {
      enable = !osConfig.programs.uwsm.enable;
      variables = [
        "--all"
      ];
    };
    settings = {
      core = {
        plugins = (lib.strings.concatStringsSep " " [
          # Accessibility:
          "invert"
          "zoom"

          # Desktop:
          "alpha"
          "cube"
          "expo"
          "idle"
          "oswitch"
          "scale"
          "vswitch"
          # "vswipe"
          "window-rules"
          # "wsets"

          # Effects:
          "animate"
          "blur"
          "decoration"
          # "fisheye"
          # "wobbly"
          # "wrot"

          # General
          "autostart"
          "command"

          # Utility
          "session-lock"
          "xdg-activation"

        # Window management:
          # "fast-switcher"
          "grid"
          "move"
          "place"
          "preserve-output"
          # "simple-tile"
          "switcher"
          "resize"
          "wm-actions"

          # ???
          # "foreign-toplevel"         
          # "gtk-shell"
          # "shortcuts-inhibit"
          #"wayfire-shell"
          
        ]);
        close_top_view = "<super> KEY_W";
        vwidth = 3;
        vheight = 3;
        preferred_decoration_mode = "client";
      };
      # General:
      autostart = {
        env = "SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh";
      };
      command = {
        # apps:
        binding_terminal = "<super> KEY_ENTER";
        command_terminal = "${apps.terminal}";

        binding_spare_terminal = "<super> T";
        command_spare_terminal = "${apps.spare-terminal}";

        binding_launcher = "<super> KEY_M";
        command_launcher = "${apps.launcher}";
      };
      input = {
        xkb_layout = devices.keyboard.settings.kb_layout;
        xkb_options = devices.keyboard.settings.kb_options;
        kb_numlock_default_state = true;
      };
      # Desktop:
      expo = {
        background = "0.06 0.06 0.01 1.0";
        toggle = "<super> KEY_E";
        select_workspace_1 = "KEY_1";
        select_workspace_2 = "KEY_2";
        select_workspace_3 = "KEY_3";
        select_workspace_4 = "KEY_4";
        select_workspace_5 = "KEY_5";
        select_workspace_6 = "KEY_6";
        select_workspace_7 = "KEY_7";
        select_workspace_8 = "KEY_8";
        select_workspace_9 = "KEY_9";
      };
      vswitch = {
        binding_left = "<ctrl> <super> KEY_LEFT";
        binding_down = "<ctrl> <super> KEY_DOWN";
        binding_up = "<ctrl> <super> KEY_UP";
        binding_right = "<ctrl> <super> KEY_RIGHT";
        # Move the focused window with the same key-bindings, but add Shift
        with_win_left = "<ctrl> <super> <shift> KEY_LEFT";
        with_win_down = "<ctrl> <super> <shift> KEY_DOWN";
        with_win_up = "<ctrl> <super> <shift> KEY_UP";
        with_win_right = "<ctrl> <super> <shift> KEY_RIGHT";
        # Go to workspace N
        binding_1 = "<super> KEY_1";
        binding_2 = "<super> KEY_2";
        binding_3 = "<super> KEY_3";
        binding_4 = "<super> KEY_4";
        binding_5 = "<super> KEY_5";
        binding_6 = "<super> KEY_6";
        binding_7 = "<super> KEY_7";
        binding_8 = "<super> KEY_8";
        binding_9 = "<super> KEY_9";
        # Go to workspace N with currently focused window
        with_win_1 = "<super> <shift> KEY_1";
        with_win_2 = "<super> <shift> KEY_2";
        with_win_3 = "<super> <shift> KEY_3";
        with_win_4 = "<super> <shift> KEY_4";
        with_win_5 = "<super> <shift> KEY_5";
        with_win_6 = "<super> <shift> KEY_6";
        with_win_7 = "<super> <shift> KEY_7";
        with_win_8 = "<super> <shift> KEY_8";
        with_win_9 = "<super> <shift> KEY_9";
      };
      #Effects:
      blur = {
        enable = true;
      };
      decoration = {
        active_color = "0.06 0.06 0.01 1.0";
        inactive_color = "0.06 0.06 0.01 1.0";
        border_size = 4;  # default
        font = "${config.gtk.font.name} ${toString config.gtk.font.size}";
        title_height = 30;  # default;
        button_order = "close";  # default
        # ignore_views = "";
      };
    };
  };
}
