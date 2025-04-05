# █░█░█ █ █▀▄ █▀▀ █▀▀ ▀█▀ █▀ ▀
# ▀▄▀▄▀ █ █▄▀ █▄█ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, ... }: let
  inherit (config.colorScheme)
    palette
    variant;
  inherit (config.desktop)
    apps
    scripts;
  in {
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
    keyboard-name = config.desktop.devices.keyboard.name;
  };
  # ! doesn't work propertly on Hyprland (waiting...)
  # ? see https://github.com/hyprwm/Hyprland/discussions/1094
  # "wlr/taskbar" = {
  #   format = "{icon} {name}";
  #   icon-size = 16;
  #   icon-theme = "${config.gtk.iconTheme.name}";
  #   tooltip-format = "{title} {state}";
  #   on-click = "minimize-raise";
  #   on-click-middle = "close";
  #   ignore-list = [
  #     "org.wezfurlong.wezterm"
  #     # add more here ...
  #   ];
  #   app_ids-mapping = {
  #     firefoxdeveloperedition = "firefox-developer-edition";
  #   };
  #   rewrite = {
  #     "Mozilla Firefox" = "Firefox";
  #     "Visual Studio Code" = "VSCode";
  #     # add more here ...
  #   };
  # };
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
}
