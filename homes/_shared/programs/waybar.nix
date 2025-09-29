# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, lib, osConfig, ... }: let
  #! -- -- -- vars -- -- -- !#
  inherit (config.colorScheme)
    variant
    palette;
  inherit (config.desktop)
    devices
    scripts;
  nixLogo = builtins.fetchurl {
    name = "waybar-nixos-logo.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/56b7a5788005a3eaecb5298f0dbed0f7d1573abc/logo/nix-snowflake-colours.svg";
    sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
  };
  in {
  programs.waybar = {
    enable = lib.mkDefault config.wayland.windowManager.hyprland.enable;
    systemd = {
      enable = !osConfig.programs.uwsm.enable;
      target = "hyprland-session.target";
    };
    settings = {
      topBar = {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        gtk-layer-shell = true;
        height = 39;
        #! -- -- -- -- widgets (enabled) -- -- -- -- #!
        modules-left = [
          "custom/logo"
        ] ++ lib.optionals config.wayland.windowManager.hyprland.enable [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "group/monitoring"
          "group/control-center"
        ] ++ [
          "privacy"
        ] ++ lib.optionals (!config.services.swaync.enable) [ "custom/power" ];
        #! -- -- -- -- widgets (config) -- -- -- -- #!
        #common:
        "custom/logo" = {
          tooltip = false;
          format = " ";
          on-click = "${scripts.waybar.launcher-toggle}";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "${scripts.waybar.logout}";
          format = "";
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
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip = false;
        };
        tray = {
          spacing = 10;
          reverse-direction = true;
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
        # monitoring:
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
        # controllers:
        pulseaudio = {
          tooltip = false;
          format = "{icon}";
          format-bluetooth = "{icon}";
          format-muted = "󰖁";
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
        # groups:
        "group/monitoring" = {
          orientation = "inherit";
          modules = [
            "cpu"
            "memory"
            "disk"
          ] ++ lib.optionals devices.battery.enable [ "battery" ];
        };
        "group/control-center" = {
          orientation = "inherit";
          modules = [ ]
            ++ lib.optionals config.wayland.windowManager.hyprland.enable [
            "hyprland/language"
            "custom/swallow"
            "custom/hyprsunset"
          ] ++ [
            "pulseaudio"
            (if devices.ddcci.enable then "custom/ddcutil" else "backlight")
            "idle_inhibitor"
          ] ++ lib.optionals config.services.swaync.enable [
            "custom/notification"
          ];
        };
      } // lib.optionalAttrs config.wayland.windowManager.hyprland.enable {
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
          format = "{}";
          format-en = "us";
          format-ru = "ru";
          keyboard-name = devices.keyboard.settings.name;
          on-click = "${scripts.waybar.switch-keyboard-layout}";
        };
        "custom/swallow" = {
          format = "{}";
          exec = "${scripts.waybar.hyprctl-swallow}";
          return-type = "json";
          on-click = "${scripts.waybar.hyprctl-swallow-toggle}";
          escape = true;
        };
        "custom/hyprsunset" = {
          format = "{}";
          exec = "${scripts.waybar.hyprctl-hyprsunset}";
          return-type = "json";
          on-click = "${scripts.waybar.hyprctl-hyprsunset-toggle}";
          escape = true;
        };
      } // lib.optionalAttrs config.services.swaync.enable {
        "custom/notification" = {
          exec = "${scripts.waybar.notification-get}";
          return-type = "json";
          format = "{icon}  ";
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
      } // lib.optionalAttrs devices.battery.enable {
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
      } // lib.optionalAttrs devices.ddcci.enable {
        "custom/ddcutil" = {
          format = "{icon}";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          tooltip = false;
          exec = "${scripts.waybar.ddcutil-fast}";
          on-scroll-up = "${scripts.waybar.ddcutil-up}";
          on-scroll-down = "${scripts.waybar.ddcutil-down}";
          on-click = "${scripts.waybar.ddcutil-bright}";
          on-click-right = "${scripts.waybar.ddcutil-dark}";
          return-type = "json";
        };
      } // lib.optionalAttrs (!devices.ddcci.enable) {
        backlight = {
          min = 5;
          max = 100;
          tooltip = false;
          format = "{icon}";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          reverse-scrolling = true;
          reverse-mouse-scrolling = false;
          on-scroll-up = "${scripts.waybar.brightness-up}";
          on-scroll-down = "${scripts.waybar.brightness-down}";
        };
      };
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
      * Taskbar (doesn't work properly on Hyprland)
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
      #cpu,
      #memory,
      #disk,
      #battery,
      #language,
      #pulseaudio,
      #custom-ddcutil,
      #custom-swallow,
      #custom-hyprsunset,
      #backlight,
      #idle_inhibitor,
      #custom-notification {
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        margin-left: 6px;
        margin-right: 6px;
        padding: 0px 2px 0px 2px;
      }

      #custom-swallow.hidden,
      #custom-hyprsunset {
          margin-left: 0;
          margin-right: 0;
          padding: 0;
          border: none;
          min-width: 0;
      }

      #custom-swallow.visible,
      #custom-hyprsunset {
          min-width: 0;
          margin-left: 6px;
          margin-right: 6px;
          padding: 0px 2px 0px 2px;
          color: #${palette.base00};
      }

      #language {
        margin-right: 2px;
        padding-top: 1px; 
        padding-bottom: 4px; 
      }

      #clock {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        margin:7px 3px 7px 3px;
        padding: 0px 9px 0px 9px;
        border-radius: 15px;
        background-color: #${palette.base05};
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
        background-color: #${palette.base08};
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
        background-color: #${palette.base01};
        color: #${palette.base05};
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
    * Override colors
    * ----------------------------------------------------- */

      @keyframes blink {
        to {
          background-color: #${palette.base01};
          color: #${palette.base05};
        }
      }

      @keyframes text-blink-critical {
        to {
          color: red;
        }
      }

      #disk.docker.critical,
      #disk.games.critical,
      #disk.home.critical,
      #disk.kvm.critical,
      #disk.nix.critical,
      #disk.critical,
      #battery.critical:not(.charging) {
        animation: text-blink-critical 0.5s ease-in-out infinite alternate;
      }

    /* -----------------------------------------------------
    * Groups
    * ----------------------------------------------------- */

      #monitoring {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        border-radius: 15px;
        padding-left: 6px;
        padding-right: 6px;
        margin: 7px 3px;
        color: #${palette.base00};
        
        background: linear-gradient(
          90deg,
          #${palette.base0E},
          #${palette.base0D},
          #${palette.base0C}
        );
        transition: all 0.6s ease-in-out;
      }

      #monitoring:hover {
        color: #${palette.base00};
        background: #${palette.base05};
      }


      #control-center {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        border-radius: 15px;
        padding-left: 6px;
        padding-right: 6px;
        margin: 7px 3px;
        color: #${palette.base00};
        
        background: linear-gradient(
          90deg,
          #${palette.base0B},
          #${palette.base0A},
          #${palette.base09},
          #${palette.base08}
        );
        transition: all 0.6s ease-in-out;
      }

      #control-center:hover {
        color: #${palette.base00};
        background: #${palette.base05};
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
