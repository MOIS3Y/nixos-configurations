# █▀ █░█░█ ▄▀█ █▄█ █▄░█ █▀▀ ▀
# ▄█ ▀▄▀▄▀ █▀█ ░█░ █░▀█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  services.swaync = {
    enable = true;
    settings = {
      # General settings
      cssPriority = "user";
      image-visibility = "when-available";
      keyboard-shortcut = true;
      relative-timestamps = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      script-fail-notify = true;
      transition-time = 200;

      # Layer settings
      layer-shell = true;
      # layer = "overlay";
      # control-center-layer = "overlay";

      # Notification settings
      positionX = "center";
      positionY = "top";
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 300;

      # Control center settings
      control-center-positionX = "left";
      control-center-positionY = "top";
      control-center-margin-top = 4;
      control-center-margin-bottom = 4;
      control-center-margin-left = 0;
      control-center-margin-right = 4;
      control-center-width = 450;
      control-center-exclusive-zone = true;
      fit-to-screen = true;
      hide-on-action = true;
      hide-on-clear = false;

      # Widget settings
      widgets = [
        "title"
        "mpris"
        "notifications"
        "dnd"
      ];

      # Widget config
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          blur = true;
        };
        dnd = {
          text = "Do Not Disturb";
        };
      };
    };

    # Custom style
    style = with config.colorScheme.palette; let
      variant = "${config.colorScheme.variant}";
      dark01 = "rgba(12, 12, 12, 0.1)";
      light01 = "rgba(255, 255, 255, 0.1)";
      dark04 = "rgba(12, 12, 12, 0.4)";
      light04 = "rgba(255, 255, 255, 0.4)";
    in ''
      @define-color background #${base00};
      @define-color background-alt ${if variant == "dark" then dark01 else light01};
      @define-color background-focus ${if variant == "dark" then dark04 else light04};

      @define-color border #${base02};
      
      @define-color base00 #${base00};
      @define-color base01 #${base01};
      @define-color base02 #${base02};
      @define-color base03 #${base03};
      @define-color base04 #${base04};
      @define-color base05 #${base05};
      @define-color base08 #${base08};
      @define-color base09 #${base09};
      @define-color base0A #${base0A};
      @define-color base0B #${base0B};
      @define-color base0D #${base0D};

      * {
        all: unset;
        font: 14px Ubuntu, Inter, sans-serif;
        transition: 200ms;
      }

      /*** Global ***/
      progress,
      progressbar,
      trough {
        border: 1px @border;
        border-radius: 15px;
        padding: 0.11rem;
      }

      trough {
        background: @base01;
      }

      .notification.low,
      .notification.normal {
        border: 1px solid @border;
      }

      .notification.low progress,
      .notification.normal progress {
        background: @base0D;
      }

      .notification.critical {
        border: 1px solid @base08;
      }

      .notification.critical progress {
        background: @base08;
      }

      .summary {
        color: @base05;
      }

      .body {
        color: alpha(@base05, 0.7);
      }

      .time {
        color: alpha(@base05, 0.7);
      }

      .app-icon,
      .image {
        -gtk-icon-effect: none;
        margin: 0.25rem;
      }

      .notification-action {
        color: @base05;
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 8px;
        margin: 0.5rem;
      }

      .notification-action:hover {
        background: @background-focus;
        color: @base05;
      }

      .notification-action:active {
        background: @base0D;
        color: @base05;
      }

      .close-button {
        margin: 0.5rem;
        padding: 0.25rem;
        border-radius: 15px;
        color: @base05;
        background: @base01;
      }

      .close-button:hover {
        background: @base02;
      }

      .close-button:active {
        background: @base02;
      }

      /*** Notifications ***/
      .floating-notifications.background .notification-row .notification-background {
        background: @background;
        border-radius: 16px;
        color: @base05;
        margin: 0.25rem;
        padding: 0;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification {
        padding: 0.5rem;
        border-radius: 16px;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        .notification-content {
        margin: 0.5rem;
      }

      /*** Notifications Group ***/
      .notification-group {
        /* Styling only for Grouped Notifications */
      }

      .notification-group.low {
        /* Low Priority Group */
      }

      .notification-group.normal {
        /* Low Priority Group */
      }

      .notification-group.critical {
        /* Low Priority Group */
      }

      .notification-group .notification-group-buttons,
      .notification-group .notification-group-headers {
        margin: 0.5rem;
        color: @base05;
      }

      .notification-group .notification-group-headers {
        /* Notification Group Headers */
      }

      .notification-group .notification-group-headers .notification-group-icon {
        color: @base05;
      }

      .notification-group .notification-group-headers .notification-group-header {
        color: @base05;
      }

      .notification-group .notification-group-buttons {
        /* Notification Group Buttons */
      }

      .notification-group.collapsed .notification-row .notification {
        background: @background-alt;
      }

      .notification-group.collapsed .notification-row:not(:last-child) {
        /* Top notification in stack */
        /* Set lower stacked notifications opacity to 0 */
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
        background: @background-focus;
      }

      /*** Control Center ***/
      .control-center {
        background: @background;
        border: 1px solid @border;
        border-radius: 16px;
        color: @base05;
        padding: 1rem;
      }

      .control-center-list {
        background: transparent;
      }

      .control-center .notification-row .notification-background {
        background: @background-alt;
        border-radius: 8px;
        color: @base05;
        margin: 0.5rem;
      }

      .control-center .notification-row .notification-background .notification {
        border-radius: 8px;
        padding: 0.5rem;
      }

      .control-center
        .notification-row
        .notification-background
        .notification
        .notification-content {
        margin: 0.5rem;
      }

      .control-center
        .notification-row
        .notification-background
        .notification
        .notification-content
        .time {
        margin-right: 0.75rem;
      }

      .control-center .notification-row .notification-background:hover {
        background: @background-focus;
        color: @base05;
      }

      .control-center .notification-row .notification-background:active {
        background: @base0D;
        color: @base05;
      }

      /*** Widgets ***/
      /* Title widget */
      .widget-title {
        color: @base05;
        margin: 0.5rem;
      }

      .widget-title > label {
        font-weight: bold;
      }

      .widget-title > button {
        background: @base01;
        border: 1px solid @border;
        border-radius: 8px;
        color: @base05;
        padding: 0.5rem;
      }

      .widget-title > button:hover {
        background: @base02;
      }

      /* DND Widget */
      .widget-dnd {
        color: @base05;
        margin: 0.5rem;
      }

      .widget-dnd > label {
        font-weight: bold;
      }

      .widget-dnd > switch {
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 15px;
      }

      .widget-dnd > switch:hover {
        background: @background-focus;
      }

      .widget-dnd > switch:checked {
        background: @base0D;
        color: @base00;
      }

      .widget-dnd > switch slider {
        background: @base01;
        border-radius: 15px;
        padding: 0.11rem;
        margin: 0.11rem;
      }

      /* Mpris widget */
      .widget-mpris {
        color: ${if variant == "dark" then "@base05" else "@base01"};
      }

      .widget-mpris .widget-mpris-player {
        border: 1px solid @border;
        border-radius: 8px;
        margin: 0.5rem;
        padding: 0.5rem;
      }

      .widget-mpris .widget-mpris-player button:hover {
        background: @background-focus;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        border-radius: 16px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-weight: bold;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        font-weight: normal;
      }

      .widget-mpris .widget-mpris-player > box > button {
        border: 1px solid transparent;
        border-radius: 8px;
        padding: 0.25rem;
      }

      .widget-mpris .widget-mpris-player > box > button:hover {
        background: @background-focus;
        border: 1px solid @border;
      }

      .widget-mpris > box > button {
        /* Change player side buttons */
      }

      .widget-mpris > box > button:disabled {
        /* Change player side buttons insensitive */
      }
    '';
  };
}
