# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: let
  #! -- -- -- vars -- -- -- !#
  inherit (config.colorScheme)
    variant
    palette;
  inherit (config.desktop)
    apps
    devices
    scripts;
  nixLogo = builtins.fetchurl {
    name = "waybar-nixos-logo.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/56b7a5788005a3eaecb5298f0dbed0f7d1573abc/logo/nix-snowflake-colours.svg";
    sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
  };
  #! -- -- -- widgets -- -- -- !#
  widgets = {
    "hyprland/workspaces" = {
      window-rewrite = {};  # ? fix [warning] Waybar/discussions/2816
      format = "{icon}";
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "0";
        # Gasp! We’re lying here.
        # https://github.com/shezdy/hyprsplit
        "11" = "1";
        "12" = "2";
        "13" = "3";
        "14" = "4";
        "15" = "5";
        "16" = "6";
        "17" = "7";
        "18" = "8";
        "19" = "9";
        "20" = "0";
      };
      all-outputs = false;  # ? false for hyprsplit
      active-only = false;
      persistent-workspaces = { "*" = 10; };
      on-scroll-up = "${scripts.waybar.switch-workspaces-to-right}";
      on-scroll-down = "${scripts.waybar.switch-workspaces-to-left}";
    };
    "hyprland/language" = {
      format = " {}";
      format-en = " us";
      format-ru = " ru";
      keyboard-name = devices.keyboard.settings.name;
    };
    "custom/logo" = {
      tooltip = false;
      format = " ";
      on-click = "${scripts.waybar.launcher-toggle}";
    };
    "custom/filemanager" = {
      tooltip = false;
      on-click = "${apps.filemanager}";
      format = "󱂵  Files";
    };
    "custom/browser" = {
      tooltip = false;
      on-click = "${apps.browser}";
      format = "󰈹  Browser";
    };
    "custom/calc" = {
      tooltip = false;
      on-click = "${scripts.waybar.calc}";
      format = "󰃬  Calc";
    };
    "custom/terminal" = {
      tooltip = false;
      on-click = "${apps.terminal}";
      format = "  Terminal";
    };
    "custom/swallow" = {
      tooltip = false;
      on-click = "${scripts.waybar.hyprctl-swallow}";
      format = "󰊰 ";
    };
    "custom/power" = {
      tooltip = false;
      on-click = "${scripts.waybar.logout}";
      format = "";
    };
    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
      tooltip-format-activated = "Caffeine activated";
      tooltip-format-deactivated = "Caffeine deactivated";
    };
    "custom/notification" = {
      exec = "${scripts.waybar.notification-get}";
      return-type = "json";
      format = "{icon}";
      format-icons = {
        notification = "󰂚";
        none = "󰂜";
        dnd-notification = "󰂛";
        dnd-none = "󰪑";
        inhibited-notification = "󰂛";
        inhibited-none = "󰪑";
        dnd-inhibited-notification = "󰂛";
        dnd-inhibited-none = "󰪑";
      };
      on-click = "${scripts.waybar.notification-center}";
      on-click-right = "${scripts.waybar.notification-dnd}";
      tooltip = true;
      escape = true;
    };
    "custom/ddcutil" = {
      format = "{icon} {percentage}%";
      format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
      tooltip = false;
      exec = "${scripts.waybar.ddcutil-fast}";
      on-scroll-up = "${scripts.waybar.ddcutil-up}";
      on-scroll-down = "${scripts.waybar.ddcutil-down}";
      on-click = "${scripts.waybar.ddcutil-bright}";
      on-click-right = "${scripts.waybar.ddcutil-dark}";
      return-type = "json";
    };
    "group/group-apps" = {
      orientation = "inherit";
      drawer = {
          transition-duration = 500;
          children-class = "apps";
          transition-left-to-right = true;
      };
      modules = [
          "custom/logo"
          "custom/swallow"
          "custom/filemanager"
          "custom/browser"
          "custom/terminal"
          "custom/calc"
      ];
    };
    "group/group-disks" = {
        orientation = "inherit";
        drawer = {
            transition-duration = 500;
            children-class = "disks";
            transition-left-to-right = false;
        };
        modules = [
            "disk"
            "disk#home"
            "disk#nix"
        ];
    };
    disk = {
      interval = 10;
      unit = "GB";
      format = "󰋊 {percentage_used}%";
      tooltip-format = "{free} out of {total} available on {path}";
      on-click = "${scripts.waybar.gnome-disks-toggle}";
      states = {
        warning = 70;
        critical = 90;
      };
      path = "/";
    };
    "disk#nix" = {
      interval = 10;
      unit = "GB";
      format = "󰋊 nix {percentage_used}%";
      tooltip-format = "{free} out of {total} available on {path}";
      states = {
        warning = 70;
        critical = 90;
      };
      path = "/nix";
    };
    "disk#home" = {
      interval = 10;
      unit = "GB";
      format = "󰋊 home {percentage_used}%";
      tooltip-format = "{free} out of {total} available on {path}";
      states = {
        warning = 70;
        critical = 90;
      };
      path = "/home";
    };
    battery = {
      interval = 1;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      tooltip-format = "{timeTo}, {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = "󰚥 {capacity}%";
      format-alt = "{icon}  {time}";
      format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    };
    backlight = {
      min = 5;
      max = 100;
      tooltip = false;
      format = "{icon} {percent}%";
      format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
      reverse-scrolling = true;
      reverse-mouse-scrolling = false;
      on-scroll-up = "${scripts.waybar.brightness-up}";
      on-scroll-down = "${scripts.waybar.brightness-down}";
    };
    "backlight/slider" = {
      orientation = "horizontal";
      min = 5;
      max = 100;
    };
    "group/group-backlight" = {
      orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "";
          transition-left-to-right = false;
        };
      modules = [
        "backlight"
        "backlight/slider"
      ];
    };
    tray = {
      spacing = 10;
    };
    clock = {
      format = "󱑎 {:%H:%M}";
      format-alt = "󰃰 {:%a, %d %b %H:%M}";
      on-click-middle = "${scripts.waybar.gnome-calendar-toggle}";
      # locale = "en_GB.UTF-8";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode           = "year";
        mode-mon-col   = 3;
        weeks-pos      = "right";
        on-scroll      = 1;
        on-click-right = "mode";
        format = let
          # ? bold looks ugly on light mode
          bold-or-thin = "${if variant == "dark" then "<b>{}</b>" else "{}"}";
          bold-or-thin-underline = "${if variant == "dark" then "<b><u>{}</u></b>" else "<u>{}</u>"}";
        in {
          months   = "<span color='#${palette.base0D}'>${bold-or-thin}</span>";
          days     = "<span color='#${palette.base05}'>${bold-or-thin}</span>";
          weeks    = "<span color='#${palette.base07}'>${bold-or-thin}</span>";
          weekdays = "<span color='#${palette.base0E}'>${bold-or-thin}</span>";
          today    = "<span color='#${palette.base08}'>${bold-or-thin-underline}</span>";
        };
      };
      actions = {
          on-click-right = "mode";
          on-scroll-up   = "shift_up";
          on-scroll-down = "shift_down";
        };
    };
    cpu = {
        interval = 1;
        format = "󰓅  {usage}%";
        max-length =  10;
        on-click = "${scripts.waybar.btm-toggle}";
        on-click-right = "${scripts.waybar.htop-toggle}";
        on-click-middle = "${scripts.waybar.gnome-system-monitor-toggle}";
    };
    memory = {
        interval = 1;
        format = "󰍛  {percentage}%";
        max-length = 10;
        tooltip-format = "{used:0.1f}GiB used";
        on-click = "${scripts.waybar.btm-toggle}";
        on-click-right = "${scripts.waybar.htop-toggle}";
        on-click-middle = "${scripts.waybar.gnome-system-monitor-toggle}";
    };
    pulseaudio = {
      tooltip = false;
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}% 󰂯";
      format-muted = "󰖁 Mute";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["󰕿" "󰖀" "󰕾"];
      };
      tooltip-format = "{desc}, {volume}";
      on-click = "${scripts.waybar.volume-mute}";
      on-click-right = "${scripts.waybar.pavucontrol-toggle}";
      reverse-scrolling = true;
      reverse-mouse-scrolling = false;
    };
    "pulseaudio#microphone" = {
      tooltip = false;
      format = "{format_source}";
      format-source = "󰍬 {volume}%";
      format-source-muted = "󰍭 Mute";
      on-click = "${scripts.waybar.mic-mute}";
      on-click-right = "${scripts.waybar.pavucontrol-toggle}";
      on-scroll-up = "${scripts.waybar.mic-up}";
      on-scroll-down = "${scripts.waybar.mic-down}";
      reverse-scrolling = true;
      reverse-mouse-scrolling = false;
    };
    "pulseaudio/slider" = {
      orientation = "horizontal";
      min = 0;
      max = 100;
    };
    "group/group-audio" = {
      orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "";
          transition-left-to-right = false;
        };
      modules = [
        "pulseaudio"
        "pulseaudio/slider"
      ];
    };
    privacy = {
      icon-spacing = 10;
      icon-size = 12;
      transition-duration = 250;
      modules = [
        {
          type = "screenshare";
          tooltip = true;
          tooltip-icon-size = 24;
        }
        # {
        #   type = "audio-out";
        #   tooltip = true;
        #   tooltip-icon-size = 24;
        # }
        {
          type = "audio-in";
          tooltip = true;
          tooltip-icon-size = 24;
        }
      ];
    };
  };
  # ? some widgets may conflict each other
  excludeWidgets = if !devices.ddcci.enable
    then [ "custom/ddcutil" ]
    else [ "battery" "group/group-backlight" ];
  #! -- -- -- bars -- -- -- !#
  hyprBar = {
    layer = "top";
    position = "top";
    # mode = "dock";
    exclusive = true;
    passthrough = false;
    fixed-center = true;
    gtk-layer-shell = true;
    height = 39;
    modules-left = [
      "group/group-apps"
      "hyprland/workspaces"
    ];
    modules-center = [
      "custom/notification"
      "clock"
      "idle_inhibitor"
    ];
    modules-right = (lib.lists.subtractLists excludeWidgets [
      "cpu"
      "memory"
      "group/group-disks"
      "group/group-audio"
      "pulseaudio#microphone"
      "group/group-backlight"
      "custom/ddcutil"
      "hyprland/language"
      "tray"
      "battery"
      "privacy"
      "custom/power"
    ]);
  };
  in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      # ? right now waybar has configuration only for hyprland
      topBar = hyprBar // (builtins.removeAttrs widgets excludeWidgets);
    };
    style = ''
      /* -----------------------------------------------------
      *  Window
      * ----------------------------------------------------- */

      window#waybar {
        background-color: #${palette.base00};
        transition-property: background-color;
        transition-duration: 0.5s;
        font-size: 13px;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      /* -----------------------------------------------------
      *  Apps
      * ----------------------------------------------------- */

      #custom-logo {
        margin: 6px 3px 6px 9px;
        padding: 3px 12px;
        background-image: url("${nixLogo}");
        background-size: 90%;
        background-position: center;
        background-repeat: no-repeat;
      }

      
      #custom-browser,
      #custom-calc,
      #custom-filemanager,
      #custom-terminal,
      #custom-swallow {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        border-radius: 15px;
        padding-top: 2px;
        padding-bottom: 2px;
        padding-right: 14px;
        padding-left: 10px;
        margin: 7px 3px;
        color: #${palette.base05};
        background-color: #${palette.base01};
      }

      #custom-swallow {
        padding-right: 10px;
        padding-left: 18px;
      }

      /* -----------------------------------------------------
      * Workspaces 
      * ----------------------------------------------------- */

      #workspaces {
        margin: 5px 5px 5px 5px;
        padding: 3px 3px;
        border-radius: 15px;
        border: 0px;
        background-color: #${if variant == "dark" then palette.base01 else palette.base02};
      }

      #workspaces button {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
        padding: 0px 5px;
        margin: 3px 3px;
        border-radius: 15px;
        border: 0px;
        transition: all 0.3s ease-in-out;
        background-color: #${if variant == "dark" then palette.base02 else palette.base04};
        color: #${if variant == "dark" then palette.base02 else palette.base04};
      }

      #workspaces button.active {
        border-radius: 15px;
        min-width: 40px;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
        border-radius: 15px;
      }

      #workspaces button.visible {
        background-color: #${palette.base0E};
        color: #${palette.base0E};
      }
      #workspaces button.persistent {
        background-color: #${palette.base0D};
        color: #${palette.base0D};
      }
      #workspaces button.empty {
        background-color: #${if variant == "dark" then palette.base02 else palette.base04};
        color: #${if variant == "dark" then palette.base02 else palette.base04};
      }
      #workspaces button.active {
        color: #${palette.base0D};
        background-color: #${palette.base0D};
      }
      #workspaces button.urgent {
        background-color: #${palette.base08};
        color: #${palette.base08};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #workspaces button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
      color: #${palette.base00};
      background-color: #${palette.base0D};
      }

      /* -----------------------------------------------------
      * Taskbar (doesn't work propertly on Hyprland)
      * ----------------------------------------------------- */

      #taskbar {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        background-color: #${palette.base00};
        color: #${palette.base05};
      }

      #taskbar button {
        margin:7px 3px 7px 3px;
        padding: 0px 9px 0px 9px;
        border-radius: 15px;
        background-color: #${palette.base01};
        color: #${palette.base05};    
      }

      #taskbar button.active {
        background-color: #${palette.base0D};
        color: #${palette.base01};
      }

    /* -----------------------------------------------------
    * Widgets 
    * ----------------------------------------------------- */

      #battery,
      #backlight,
      #clock,
      #cpu,
      #custom-notification,
      #custom-ddcutil,
      #disk,
      #idle_inhibitor,
      #language,
      #memory,
      #pulseaudio {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        margin:7px 3px 7px 3px;
        padding: 0px 9px 0px 9px;
        border-radius: 15px;
        background-color: #${palette.base00};
        color: #${palette.base00};
        font-family: JetBrainsMono, monospace;
        font-size: 14px;
      }

      #privacy {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        margin:7px 3px 7px 3px;
        padding: 0px 16px 0px 16px;
        border-radius: 15px;
        background-color: #${palette.base00};
        color: #${palette.base00};
        font-family: JetBrainsMono, monospace;
        font-size: 14px;
      }

      #tray {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        margin:7px 3px 7px 3px;
        padding: 0px 9px 0px 9px;
        border-radius: 15px;
        background-color: #${palette.base00};
        color: #${palette.base00};
      }

      #custom-power {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        margin-right: 16px;
        margin-left: 5px;
        font-size: 18px;
        background-color: #${palette.base00};
        color: #${palette.base0F};
      }

    /* -----------------------------------------------------
    * Contollers
    * ----------------------------------------------------- */

      #backlight-slider,
      #backlight-slider *,
      #pulseaudio-slider,
      #pulseaudio-slider *,
      #group-audio,
      #group-backlight {
          margin: 0;
          padding: 0;
      }

      slider {
          min-height: 0px;
          min-width: 0px;
          opacity: 0;
          background-image: none;
          border: none;
          box-shadow: none;
      }

      trough {
          min-height: 12px;
          min-width: 80px;
          border-radius: 5px;
          background-color: #${palette.base01};
      }

      highlight {
          min-width: 12px;
          border-radius: 5px;
      }

    /* -----------------------------------------------------
    * Override colors
    * ----------------------------------------------------- */

      #battery.charging, #battery.plugged {
          color: #${palette.base00};
          background-color: #${palette.base0B};
      }

      @keyframes blink {
          to {
              background-color: #${palette.base01};
              color: #${palette.base05};
          }
      }

      #disk.docker.warning,
      #disk.games.warning,
      #disk.home.warning,
      #disk.kvm.warning,
      #disk.nix.warning,
      #disk.warning,
      #battery.warning:not(.charging) {
          background-color: #${palette.base0A};
          color: #${palette.base00};
      }

      #disk.docker.critical,
      #disk.games.critical,
      #disk.home.critical,
      #disk.kvm.critical,
      #disk.nix.critical,
      #disk.critical,
      #battery.critical:not(.charging) {
          background-color: #${palette.base08};
          color: #${palette.base00};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #battery {
        background-color: #${palette.base01};
        color: #${palette.base05};
      }

      #backlight {
        background-color: #${palette.base09};
      }

      #backlight-slider highlight {
        background-color: #${palette.base09};
      }

      #cpu {
        background-color: #${palette.base0E};
      }

      #clock {
        background-color: #${palette.base05};
        color: #${palette.base00};
      }

      #custom-ddcutil {
        background-color: #${palette.base09};
      }

      #custom-swallow {
        color: #${palette.base05};
      }

      #disk {
        background-color: #${palette.base0C};
      }

      #disk.docker,
      #disk.games,
      #disk.home,
      #disk.kvm,
      #disk.nix {
        background-color: #${palette.base01};
        color: #${palette.base05};
      }

      #language {
        background-color: #${palette.base08};
        color: #${palette.base00};
      }

      #memory {
        background-color: #${palette.base0D};
      }

      #privacy {
        background-color: #${palette.base0B};
      }

      #pulseaudio.microphone {
        background-color: #${palette.base0A};
      }

      #pulseaudio {
        background-color: #${palette.base0B};
      }

      #pulseaudio-slider highlight {
        background-color: #${palette.base0B};
      }

      #tray {
        background-color: #${palette.base01};
        color: #${palette.base05};
      }

      #idle_inhibitor {
        margin-left: 5px;
        margin-right: 5px;
        padding-left: 4px;
        background-color: #${palette.base00};
        color: #${palette.base05};
      }

      #custom-notification {
        margin-left: 5px;
        margin-right: 5px;
        background-color: #${palette.base00};
        color: #${palette.base05};
      }

    /* -----------------------------------------------------
    * Tooltips
    * ----------------------------------------------------- */

      tooltip {
        font-family: Ubuntu, Inter, sans-serif;
        border-radius: 8px;
        border-color: #${palette.base01};
        padding: 20px;
        margin: 30px;
        color: #${palette.base05};
        background-color: #${palette.base00};
      }

      tooltip label {
        font-family: Ubuntu, Inter, sans-serif;
        padding: 20px;
        color: #${palette.base05};
      }
    '';
  };
}