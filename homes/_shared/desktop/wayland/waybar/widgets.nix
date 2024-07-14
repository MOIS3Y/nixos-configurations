# █░█░█ █ █▀▄ █▀▀ █▀▀ ▀█▀ █▀ ▀
# ▀▄▀▄▀ █ █▄▀ █▄█ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: with config.desktop.scripts.waybar; {
  "hyprland/workspaces" = {
    window-rewrite = {};  # ? fix [warning] Waybar/discussions/2816
    format = "{icon}";
    all-outputs = true;
    active-only = false;
    persistent-workspaces = { "*" = 8; };
    on-scroll-up = "${switch-workspaces-to-right}";
    on-scroll-down = "${switch-workspaces-to-left}";
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
    on-click = "${launcher-toggle}";
  };
  "custom/filemanager" = {
    tooltip = false;
    on-click = "${config.desktop.apps.filemanager}";
    format = "󱂵  Files";
  };
  "custom/browser" = {
    tooltip = false;
    on-click = "${config.desktop.apps.browser}";
    format = "󰈹  Browser";
  };
  "custom/calc" = {
    tooltip = false;
    on-click = "${calc}";
    format = "󰃬  Calc";
  };
  "custom/terminal" = {
    tooltip = false;
    on-click = "${config.desktop.apps.terminal}";
    format = "  Terminal";
  };
  "custom/swallow" = {
    tooltip = false;
    on-click = "${hyprctl-swallow}";
    format = "󰊰 ";
  };
  "custom/power" = {
    tooltip = false;
    on-click = "${logout}";
    format = "";
  };
  idle_inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = "";
      deactivated = "";
    };
  };
  "custom/notification" = {
    exec = "${notification-get}";
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
    on-click = "${notification-center}";
    on-click-right = "${notification-dnd}";
    tooltip = true;
    escape = true;
  };
  "custom/ddcutil" = {
    format = "{icon} {percentage}%";
    format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
    tooltip = false;
    exec = "${ddcutil-fast}";
    on-scroll-up = "${ddcutil-up}";
    on-scroll-down = "${ddcutil-down}";
    on-click = "${ddcutil-bright}";
    on-click-right = "${ddcutil-dark}";
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
    on-scroll-up = "${brightness-up}";
    on-scroll-down = "${brightness-down}";
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
        transition-left-to-right = true;
      };
    modules = [
      "backlight"
      "backlight/slider"
    ];
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
    format = "󱑎 {:%H:%M}";
    format-alt = "󰃰 {:%a, %d %b %H:%M}";
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
        variant = "${config.colorScheme.variant}";
        bold-or-thin = "${if variant == "dark" then "<b>{}</b>" else "{}"}";
        bold-or-thin-underline = "${if variant == "dark" then "<b><u>{}</u></b>" else "<u>{}</u>"}";
      in {
        months   = "<span color='#${config.colorScheme.palette.base0D}'>${bold-or-thin}</span>";
        days     = "<span color='#${config.colorScheme.palette.base05}'>${bold-or-thin}</span>";
        weeks    = "<span color='#${config.colorScheme.palette.base07}'>${bold-or-thin}</span>";
        weekdays = "<span color='#${config.colorScheme.palette.base0E}'>${bold-or-thin}</span>";
        today    = "<span color='#${config.colorScheme.palette.base08}'>${bold-or-thin-underline}</span>";
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
  };
  memory = {
      interval = 1;
      format = "󰍛 {used:0.1f}Gb";
      max-length = 10;
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
    on-click = "${volume-mute}";
    reverse-scrolling = true;
    reverse-mouse-scrolling = false;
  };
  "pulseaudio#microphone" = {
    tooltip = false;
    format = "{format_source}";
    format-source = "󰍬 {volume}%";
    format-source-muted = "󰍭 Mute";
    on-click = "${mic-mute}";
    reverse-scrolling = true;
    reverse-mouse-scrolling = false;
    on-scroll-up = "${mic-up}";
    on-scroll-down = "${mic-down}";
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
        transition-left-to-right = true;
      };
    modules = [
      "pulseaudio"
      "pulseaudio/slider"
    ];
  };
}
