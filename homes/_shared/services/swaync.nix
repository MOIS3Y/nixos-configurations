# █▀ █░█░█ ▄▀█ █▄█ █▄░█ █▀▀ ▀
# ▄█ ▀▄▀▄▀ █▀█ ░█░ █░▀█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, lib, osConfig, ... }: let
  inherit (config.colorScheme)
    palette;
  inherit (config.desktop)
    apps
    devices
    scripts;
  in {
  services.swaync = {
    enable = lib.mkDefault config.wayland.windowManager.hyprland.enable;
    settings = {
      # General settings
      ignore-gtk-theme = true;
      cssPriority = "user";
      image-visibility = "when-available";
      keyboard-shortcut = true;
      relative-timestamps = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      transition-time = 200;

      # Layer settings
      layer-shell = true;
      layer-shell-cover-screen = true;
      layer = "overlay";
      control-center-layer = "top";

      # Notification settings
      positionX = "right";
      positionY = "top";
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-grouping = true;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 400;

      # Control center settings
      control-center-margin-top = 4;
      control-center-margin-bottom = 4;
      control-center-margin-left = 4;
      control-center-margin-right = 4;
      control-center-width = 400;
      control-center-height = 600;
      control-center-exclusive-zone = true;
      fit-to-screen = true;
      hide-on-action = true;
      hide-on-clear = false;
      text-empty = "No Notifications";

      # Scripts
      script-fail-notify = true;

      # Widget settings
      widgets = [
        "menubar"
        "volume"
        "slider#mic"
        (if devices.ddcci.enable then "slider#ddcutil" else "backlight")
        "buttons-grid"
        "mpris"
        "buttons-grid#quick-apps"
        "inhibitors"
        "title"
        "notifications"
        "dnd"
      ];

      # Widget config
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "󰃢";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          show-album-art = "always";
          loop-carousel = false;
        };
        menubar = {
          "buttons#screenshot" = {
            position = "left";
            actions = [
              {
                label = "";
                command = "swaync-client -t; ${apps.launcher}";
              }
            ];
          };
          "buttons#lockscreen" = {
            position = "right";
            actions = [
              {
                label = "";
                command = "swaync-client -t; sleep 0.5; ${scripts.swaync.screenshot}";
              }
              {
                label = "";
                command = "swaync-client -t; sleep 0.5; ${apps.lockscreen}";
              }
            ];
          };
          "menu#power" = {
            label = "⏻";
            position = "right";
            actions = [
              {
                label = "󰿅\tLogout   \t";
                command = "swaync-client -t; ${scripts.swaync.power-management} --logout";
              }
              {
                label = "󰒲\tSuspend  \t";
                command = "swaync-client -t; ${scripts.swaync.power-management} --suspend";
              }
              {
                label = "󰤄\tHibernate\t";
                command = "swaync-client -t; ${scripts.swaync.power-management} --hibernate";
              }
              {
                label = "\tReboot  \t";
                command = "swaync-client -t; ${scripts.swaync.power-management} --reboot";
              }
              {
                label = "\tShutdown\t";
                command = "swaync-client -t; ${scripts.swaync.power-management} --shutdown";
              }
            ];
          };
        };
        "buttons-grid#quick-apps" = {
          buttons-per-row = 4;
          actions = [
            {
              label = "";
              type = "normal";
              command = "swaync-client -t; ${apps.filemanager}";
            }
            {
              label = "";
              type = "normal";
              command = "swaync-client -t; ${apps.browser}";
            }
            {
              label = "";
              type = "normal";
              command = "swaync-client -t; ${apps.terminal}";
            }
            {
              label = "";
              type = "normal";
              command = "swaync-client -t; ${scripts.swaync.calc}";
            }
          ];
        };
        buttons-grid = {
          buttons-per-row = 2;
          actions = [
            {
              label = "󰊰\tSwallow Mode \t";
              type = "toggle";
              active = false;
              command = "${scripts.swaync.hyprctl-swallow} --toggle";
              update-command = "${scripts.swaync.hyprctl-swallow} --status";
            }
            {
              label = "󱩌\tNight Light  \t";
              type = "toggle";
              active = false;
              command = "${scripts.swaync.hyprctl-hyprsunset} --toggle";
              update-command = "${scripts.swaync.hyprctl-hyprsunset} --identity";
            }
            {
              label = "󰀝\tAirplane Mode\t";
              type = "toggle";
              active = false;
              command = "${scripts.swaync.airplane-mode} --toggle";
              update-command = "${scripts.swaync.airplane-mode} --status";
            }
          ] ++ lib.optionals osConfig.programs.coolercontrol.enable [
            {
              label = "󰈐\tSilent Mode  \t";
              type = "toggle";
              active = false;
              command = "${scripts.swaync.coolercontrol} --toggle";
              update-command = "${scripts.swaync.coolercontrol} --status";
            }
          ];
        };
        volume = {
          label = "";
        };
        backlight = {
          label = "󰃠";
          min = 5;
        };
        "slider#mic" = {
          label = "";
          cmd_getter = "${scripts.swaync.mic-getter}";
          cmd_setter = "${scripts.swaync.mic-setter}";
          min_limit = 0;
          max_limit = 100;
          min = 0;
          max = 100;
        };
      } // lib.optionalAttrs devices.ddcci.enable {
        "slider#ddcutil" = {
          label = "󰃠";
          cmd_getter = "${scripts.swaync.ddcutil-getter}";
          cmd_setter = "${scripts.swaync.ddcutil-setter}";
          min_limit = 0;
          max_limit = 100;
          min = 0;
          max = 100;
        };
      };
    };
    # Custom style
    style = ''
      :root {
        --cc-bg: #${palette.base00};
        --noti-border-color: #${palette.base00};
        --noti-bg: #${palette.base00};
        --noti-bg-alpha: 0.8;
        --noti-bg-darker: #${palette.base00};
        --noti-bg-hover: #${palette.base01};
        --noti-bg-focus: #${palette.base01}99;
        --noti-close-bg: #${palette.base01};
        --noti-close-bg-hover: #${palette.base02};
        --noti-progress-bg:#${palette.base02};
        --noti-progress-fg:#${palette.base0D};
        --text-color: #${palette.base05};
        --text-color-disabled: #${palette.base04};
        --bg-selected: #${palette.base0D};
        --notification-icon-size: 64px;
        --notification-app-icon-size: calc(var(--notification-icon-size) / 3);
        --notification-group-icon-size: 32px;
      }

      :root {
        --mpris-album-art-overlay: rgba(0, 0, 0, 0.55);
        --mpris-button-hover: rgba(0, 0, 0, 0.5);
        --mpris-album-art-icon-size: 96px;
      }

      :root {
        --widget-volume-row-icon-size: 24px;
      }

      :root {
        --widget-switch-bg: #${palette.base02};
        --widget-switch-checked: #${palette.base0D};
        --widget-button-checked: #${palette.base0D};
        --widget-button-checked-text: #${palette.base00};
        --widget-slider-bg: #${palette.base0D};
        --widget-slider-trought: #${palette.base01};
        --widget-slider-highlight: #${palette.base0D};
        --widget-slider-hover-contrast: #f0f0f0;
        --widget-slider-active-contrast: #f0f0f0;
      }

      .close-button {
        background: var(--noti-close-bg);
        color: var(--text-color);
        text-shadow: none;
        padding: 0;
        border-radius: 100%;
        margin-top: 8px;
        margin-right: 8px;
        box-shadow: none;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .close-button:hover {
        box-shadow: none;
        background: var(--noti-close-bg-hover);
        transition: background 0.15s ease-in-out;
        border: none;
      }

      .notification-row {
        background: none;
        outline: none;
      }

      .notification-row:focus {
        background: var(--noti-bg-focus);
      }

      .notification-row
      .notification-background {
        padding: 6px 12px;
      }

      .notification-row
      .notification-background
      .notification {
        border-radius: 12px;
        border: 1px solid var(--noti-border-color);
        padding: 0;
        transition: background 0.15s ease-in-out;
        background-color: var(--noti-bg);
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action {
        padding: 4px;
        margin: 0;
        box-shadow: none;
        background: transparent;
        border: none;
        color: var(--text-color);
        transition: background 0.15s ease-in-out;
        border-radius: 12px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action:hover {
        -gtk-icon-filter: none;
        background-color: var(--noti-bg);
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0;
        border-bottom-right-radius: 0;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content {
        background: transparent;
        border-radius: 12px;
        padding: 0;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .image {
        -gtk-icon-filter: none;
        -gtk-icon-size: var(--notification-icon-size);
        border-radius: 100px;
        margin: 4px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .app-icon {
        -gtk-icon-filter: none;
        -gtk-icon-size: var(--notification-app-icon-size);
        -gtk-icon-shadow: 0 1px 4px black;
        margin: 6px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .text-box label {
        filter: none;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .text-box
      .summary {
        font-size: 16px;
        font-weight: bold;
        background: transparent;
        color: var(--text-color);
        text-shadow: none;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .text-box
      .time {
        font-size: 16px;
        font-weight: bold;
        background: transparent;
        color: var(--text-color);
        text-shadow: none;
        margin-right: 30px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .text-box
      .body {
        font-size: 15px;
        font-weight: normal;
        background: transparent;
        color: var(--text-color);
        text-shadow: none;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content progressbar {
        margin: 8px;
        min-height: 8px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content progressbar trough {
        background-color: var(--noti-progress-bg);
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content progressbar progress {
        background-color: var(--noti-progress-fg);
        border-radius: 6px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .body-image {
        margin-top: 4px;
        background-color: white;
        -gtk-icon-filter: none;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .inline-reply {
        margin-top: 4px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .inline-reply
      .inline-reply-entry {
        background: var(--noti-bg-darker);
        color: var(--text-color);
        caret-color: var(--text-color);
        border: 1px solid var(--noti-border-color);
        border-radius: 12px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .inline-reply
      .inline-reply-button {
        margin-left: 4px;
        background: rgba(var(--noti-bg), var(--noti-bg-alpha));
        border: 1px solid var(--noti-border-color);
        border-radius: 12px;
        color: var(--text-color);
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .inline-reply
      .inline-reply-button:disabled {
        background: initial;
        color: var(--text-color-disabled);
        border: 1px solid var(--noti-border-color);
        border-color: transparent;
      }

      .notification-row
      .notification-background
      .notification
      .notification-default-action
      .notification-content
      .inline-reply
      .inline-reply-button:hover {
        background: var(--noti-bg-hover);
      }

      .notification-row
      .notification-background
      .notification
      .notification-alt-actions {
        background: none;
        border-bottom-left-radius: 12px;
        border-bottom-right-radius: 12px;
        padding: 4px;
      }

      .notification-row
      .notification-background
      .notification
      .notification-action {
        margin: 4px;
        padding: 0;
      }

      .notification-row
      .notification-background
      .notification
      .notification-action > button {
        border-radius: 12px;
      }

      .notification-group {
        transition: opacity 200ms ease-in-out;
        /* Priority-specific styling */
      }

      .notification-group:focus {
        background-color: var(--cc-bg);
      }

      .notification-group
      .notification-group-close-button
      .close-button {
        margin: 12px 20px;
      }

      .notification-group
      .notification-group-buttons,
      .notification-group
      .notification-group-headers {
        margin: 0 16px;
        color: var(--text-color);
      }

      .notification-group
      .notification-group-headers
      .notification-group-icon {
        color: var(--text-color);
        -gtk-icon-size: var(--notification-group-icon-size);
      }

      .notification-group
      .notification-group-headers
      .notification-group-header {
        color: var(--text-color);
        font-size: 1.1rem;
      }

      .notification-group.collapsed.not-expanded {
        opacity: 0.9;
      }

      .notification-group.collapsed .notification-row .notification {
        background-color: rgba(var(--noti-bg), 1);
      }

      .notification-group.collapsed
      .notification-row:not(:last-child)
      .notification-action,
      .notification-group.collapsed
      .notification-row:not(:last-child)
      .notification-default-action {
        opacity: 0;
      }

      .notification-group.collapsed:hover
      .notification-row:not(:only-child)
      .notification {
        background-color: var(--noti-bg-hover);
      }

      .control-center {
        background: var(--cc-bg);
        color: var(--text-color);
        border-radius: 12px;
      }

      .control-center
      .control-center-list-placeholder {
        opacity: 0.5;
      }

      .control-center
      .control-center-list {
        background: transparent;
      }

      .control-center .control-center-list .notification {
        box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7), 0 2px 6px 2px rgba(0, 0, 0, 0.3);
      }

      .control-center .control-center-list .notification .notification-default-action,
      .control-center .control-center-list .notification .notification-action {
        transition: opacity 400ms ease-in-out, background 0.15s ease-in-out;
      }

      .control-center .control-center-list .notification .notification-default-action:hover,
      .control-center .control-center-list .notification .notification-action:hover {
        background-color: var(--noti-bg-hover);
      }

      .blank-window {
        background: transparent;
      }

      .floating-notifications {
        background: transparent;
      }

      .floating-notifications .notification {
        box-shadow: none;
      }

      .widget-title {
        margin: 4px 8px 4px 8px;
      }

      .widget-title > label {
        font-size: 1.4rem;
      }

      .widget-title > button {
        margin: 8px;
        border-radius: 12px;
      }

      .widget-dnd {
        margin: 8px;
      }

      .widget-dnd label {
        color: var(--text-color);
        margin: 8px;
        font-size: 1.1rem;
      }

      .widget-dnd switch {
        background-color: var(--widget-switch-bg);
        border-radius: 12px;
        margin: 8px;
      }

      .widget-dnd switch:checked {
        background-color: var(--widget-switch-checked);
      }

      .widget-dnd switch slider {
        border-radius: 12px;
      }

      .widget-dnd switch slider:hover {
        background-color: var(--widget-slider-hover-contrast);
      }

      .widget-dnd switch slider:active {
        background-color: var(--widget-slider-active-contrast);
      }

      .widget-label {
        margin: 8px;
      }

      .widget-label > label {
        font-size: 1.1rem;
      }

      .widget-mpris {
        margin: 8px;
      }

      .widget-mpris .widget-mpris-player {
        margin: 16px 20px;
        border-radius: 12px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
      }

      .widget-mpris .widget-mpris-player .mpris-background {
        filter: blur(10px);
      }

      .widget-mpris .widget-mpris-player .mpris-overlay {
        padding: 16px;
        background-color: var(--mpris-album-art-overlay);
      }

      .widget-mpris .widget-mpris-player .mpris-overlay button:hover {
        background: var(--noti-bg-hover);
      }

      .widget-mpris .widget-mpris-player .mpris-overlay .widget-mpris-album-art {
        border-radius: 12px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
        -gtk-icon-size: var(--mpris-album-art-icon-size);
      }

      .widget-mpris .widget-mpris-player .mpris-overlay .widget-mpris-title {
        font-weight: bold;
        font-size: 1.25rem;
      }

      .widget-mpris .widget-mpris-player .mpris-overlay .widget-mpris-subtitle {
        font-size: 1.1rem;
      }

      .widget-mpris .widget-mpris-player .mpris-overlay > box > button:hover {
        background-color: var(--mpris-button-hover);
      }

      .widget-buttons-grid {
        padding: 8px;
        margin: 4px 10px 4px 10px;
        border-radius: 12px;
      }

      .widget-buttons-grid flowboxchild > button {
        border-radius: 12px;
      }

      .widget-buttons-grid flowboxchild > button.toggle:checked {
        /* style given to the active toggle button */
        background-color: var(--widget-button-checked);
        color: var(--widget-button-checked-text);
      }

      .widget-menubar > .menu-button-bar > .start {
        margin-left: 8px;
        margin-top: 8px;
      }

      .widget-menubar > .menu-button-bar > .end {
        margin-right: 8px;
        margin-top: 8px;
      }

      .widget-menubar > .menu-button-bar > .widget-menubar-container button {
        font-size: 16px;
        min-width: 48px;
        border-radius: 12px;
        padding-left: 1px;
        padding-right: 5px;
        margin: 0 4px;
      }

      .widget-menubar > revealer {
        margin-top: 8px;
        margin-left: 8px;
        margin-right: 8px;
      }

      .widget-menubar > revealer button {
        border-radius: 12px;
        margin: 8px;
        margin-top: 0;
      }

      .widget-volume,
      .widget-slider,
      .widget-backlight {
        padding: 2px 8px 2px 8px;
        margin: 4px 10px 4px 10px;
        border-radius: 12px;
      }

      .widget-volume trough,
      .widget-slider trough,
      .widget-backlight trough {
        background-color: var(--widget-slider-trought);
        border-radius: 6px;
        min-height: 6px;
      }

      .widget-volume trough highlight,
      .widget-slider trough highlight,
      .widget-backlight trough highlight {
        background-color: var(--widget-slider-highlight);
        border-radius: 6px;
      }

      .widget-volume slider,
      .widget-slider slider,
      .widget-backlight slider {
        background-color: var(--widget-slider-bg);
        border-radius: 50%;
        min-width: 16px;
        min-height: 16px;
      }

      .widget-volume row image {
        -gtk-icon-size: var(--widget-volume-row-icon-size);
      }

      .per-app-volume {
        background-color: var(--noti-bg-alt);
        padding: 4px 8px 8px 8px;
        margin: 0px 8px 8px 8px;
        border-radius: 12px;
      }

      .widget-slider label {
        font-size: 18px;
        margin-right: 5px;
      }

      .widget-volume label {
        margin-right: 5px;
      }

      .widget-inhibitors > label {
        margin: 8px;
        font-size: 1.5rem;
      }

      .widget-inhibitors > button {
        margin: 8px;
        border-radius: 12px;
      }
    '';
  };
}
