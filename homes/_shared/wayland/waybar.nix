# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }:
  let
    nixLogo = builtins.fetchurl rec {
      name = "Logo-${sha256}.svg";
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
      sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
    };
    # bin tools:
    pamixer = "${pkgs.pamixer}/bin/pamixer";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    dunstctl = "${pkgs.dunst}/bin/dunstctl";
    wlogout = "${pkgs.wlogout}/bin/wlogout";
    notify-send = "${pkgs.libnotify}/bin/notify-send";
    rg = "${pkgs.ripgrep}/bin/rg";
    # ? sound and brightness managment (see dunst.nix - scripts there) 
    volumectl = "dunst-volume";
    microphonectl = "dunst-microphone";
    waybar-dunst-status = with pkgs; writeShellScript "waybar-dunst-status" ''
      COUNT="$(${dunstctl} count waiting)"
      ENABLED=""
      DISABLED=""
      if [ $COUNT != 0 ]; then DISABLED="$COUNT "; fi
      if ${dunstctl} is-paused | grep -q "false" ; then echo $ENABLED; else echo $DISABLED; fi
    '';
    waybar-swallow = with pkgs; writeShellScript "waybar-swallow" ''
        if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
          ${hyprctl} keyword misc:enable_swallow false >/dev/null &&
            ${notify-send} -a Hyprland -i display "Turned off swallowing"
        else
          ${hyprctl} keyword misc:enable_swallow true >/dev/null &&
            ${notify-send} -a Hyprland -i display "Turned on swallowing"
        fi
      '';
  in {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # mode = "dock";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        gtk-layer-shell = true;
        height = 36;
        # -- positions -- #
        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
          "custom/swallow"
          "idle_inhibitor"
          "custom/dunst"
          "tray"
        ];
        modules-center = [];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio#microphone"
          "pulseaudio"
          "hyprland/language"
          "clock#date"
          "clock"
          "custom/power"
        ];
        # -- widgets -- #
        "custom/logo" = {
          tooltip = false;
          format = " ";
        };
        "hyprland/workspaces" = {
          window-rewrite = {};  # ? fix [warning] Waybar/discussions/2816
          format = "{icon}";
          all-outputs = true;
          active-only = false;
          persistent-workspaces = { "*" = 8; };
          on-scroll-up = "${hyprctl} dispatch workspace e+1";
          on-scroll-down = "${hyprctl} dispatch workspace e-1";
        };
        "custom/swallow" = {
          tooltip = false;
          on-click = "${waybar-swallow}";
          format = "󰊰";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        "hyprland/language" = {
          format = " {}";
          format-en = " us";
          format-ru = " ru";
        };
        clock = {
          tooltip = false;
          format = "󱑎 {:%H:%M}";
        };
        "clock#date" = {
          format = "󰃭 {:%a,%d %b}";
          # format-alt = "󰃰 {:%a, %d %b}";
          # locale = "en_GB.UTF-8";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode           = "year";
            mode-mon-col   = 3;
            weeks-pos      = "right";
            on-scroll      = 1;
            on-click-right = "mode";
            format = {
              months   = "<span color='#89b4fa'><b>{}</b></span>";
              days     = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks    = "<span color='#b4befe'><b>{}</b></span>";
              weekdays = "<span color='#cba6f7'><b>{}</b></span>";
              today    = "<span color='#f38ba8'><b><u>{}</u></b></span>";
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
            format = "󰓅 CPU:{usage}%";
            max-length =  10;
        };
        memory = {
            interval = 1;
            format = "󰍛 {used:0.1f}Gb";
            max-length = 10;
        };
        pulseaudio = {
          tooltip = false;
          format = "{icon} {volume}";
          format-bluetooth = "{icon} {volume} 󰂯";
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
          on-click = "${volumectl} -t";
          on-scroll-up = "${volumectl} -i 5";
          on-scroll-down = "${volumectl} -d 5";
        };
        "pulseaudio#microphone" = {
          tooltip = false;
          format = "{format_source}";
          format-source = "󰍬 {volume}";
          format-source-muted = "󰍭 Mute";
          on-click = "${microphonectl} --default-source -t";
          on-scroll-up = "${microphonectl} --default-source -i 5";
          on-scroll-down = "${microphonectl} --default-source -d 5";
        };
        "custom/dunst" = {
            tooltip = false;
            return-type = "str";
            format = "{}";
            exec = "${waybar-dunst-status}";
            on-click = "${dunstctl} set-paused toggle";
            restart-interval = 1;
        };
        "custom/power" = {
          tooltip = false;
          on-click = "${wlogout}";
          format = "";
        };
      };
    };
    style = ''
      window#waybar {
        background-color: #11111b;
        transition-property: background-color;
        transition-duration: 0.5s;
        font-size: 13px;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      #custom-logo {
        margin: 6px 3px 6px 9px;
        padding: 3px 12px;
        background-image: url("${nixLogo}");
        background-size: 90%;
        background-position: center;
        background-repeat: no-repeat;
      }

      #workspaces {
        background-color: transparent;
      }

      #workspaces button {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
        padding: 3px 14px;
        margin: 6px 3px;
        border-radius: 6px;
        color: #cdd6f4;
        transition: 0.5s;
      }

      #workspaces button.persistent {
        background-color: #89b4fa;
        color: #1e1e2e;
      }
      #workspaces button.empty {
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      #workspaces button.urgent {
        background-color: #f38ba8;
        color: #1e1e2e;
      }

      #workspaces button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
      color: #1e1e2e;
      background-color: #bac2de;
      }

      #custom-swallow,
      #idle_inhibitor,
      #custom-dunst {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        border-radius: 6px;
        padding-top: 2px;
        padding-bottom: 2px;
        padding-right: 14px;
        padding-left: 10px;
        margin: 6px 3px;
        color: #cdd6f4;
        background-color: #1e1e2e;
      }

      #tray {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        border-radius: 6px;
        margin: 6px 3px;
        padding: 3px 12px;
        background-color: #1e1e2e;
        color: #181825;
      }

      #custom-weather,
      #custom-power,
      #custom-todo,
      #custom-weather,
      #battery,
      #backlight,
      #cpu,
      #memory,
      #pulseaudio,
      #language,
      #clock {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        padding: 2px 10px;
        margin: 6px 3px;
        border-radius: 4px;
        background-color: #1e1e2e;
        color: #181825;
        font-family: JetBrainsMono, monospace;
        font-size: 14px;
      }

      #custom-power {
        margin-right: 6px;
        font-size: 14px;
        font-family: JetBrainsMono;
        padding-top: 2px;
        padding-right: 12px;
        padding-bottom: 2px;
        padding-left: 10px;
      }

      #custom-weather,
      #custom-todo {
        color: #cdd6f4;
        background-color: #1e1e2e;
      }

      #custom-swallow {
        color: #cdd6f4;
      }

      #battery {
        background-color: #f38ba8;
      }

      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }

      .warning,
      .critical,
      .urgent,
      #battery.critical:not(.charging) {
        background-color: #f38ba8;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #cpu {
        background-color: #f38ba8;
      }

      #memory {
        background-color: #fab387;
      }

      #pulseaudio.microphone {
        background-color: #f9e2af;
      }

      #pulseaudio {
        background-color: #a6e3a1;
      }

      #language {
        background-color: #94e2d5;
      }

      #clock.date {
        background-color: #89b4fa;
      }

      #clock {
        background-color: #cba6f7;
      }

      #custom-power {
        background-color: #f2cdcd;
      }

      tooltip {
        font-family: Ubuntu, Inter, sans-serif;
        border-radius: 8px;
        border-color: #1e1e2e;
        padding: 20px;
        margin: 30px;
        color: #cdd6f4;
        background-color: #11111b;
      }

      tooltip label {
        font-family: Ubuntu, Inter, sans-serif;
        padding: 20px;
        color: #cdd6f4;
      }
    '';
  };
}
