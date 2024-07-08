# █░█░█ █ █▀▄ █▀▀ █▀▀ ▀█▀ █▀ ▀
# ▀▄▀▄▀ █ █▄▀ █▄█ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }:
  let
    scripts = import ./scripts.nix { inherit config; inherit pkgs; inherit lib;};
  in {
  "hyprland/workspaces" = {
    window-rewrite = {};  # ? fix [warning] Waybar/discussions/2816
    format = "{icon}";
    all-outputs = true;
    active-only = false;
    persistent-workspaces = { "*" = 8; };
    on-scroll-up = "${scripts.hyprctl} dispatch workspace e+1";
    on-scroll-down = "${scripts.hyprctl} dispatch workspace e-1";
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
    on-click = "${scripts.wofi-toggle}";
  };
  "custom/filemanager" = {
    tooltip = false;
    on-click = "${scripts.file-manager-toggle}";
    format = "󱂵  Files";
  };
  "custom/browser" = {
    tooltip = false;
    on-click = "${scripts.browser}";
    format = "󰈹  Browser";
  };
  "custom/calc" = {
    tooltip = false;
    on-click = "${scripts.calc}";
    format = "󰃬  Calc";
  };
  "custom/terminal" = {
    tooltip = false;
    on-click = "${scripts.terminal}";
    format = "  Terminal";
  };
  "custom/swallow" = {
    tooltip = false;
    on-click = "${scripts.hyprctl-swallow}";
    format = "󰊰 ";
  };
  "custom/power" = {
    tooltip = false;
    on-click = "${scripts.wlogout}";
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
    exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
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
    on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
    on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
    tooltip = true;
    escape = true;
  };
  "custom/ddcutil" = {
    format = "{icon} {percentage}%";
    format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
    tooltip = false;
    exec = "${scripts.ddcutil-fast}";
    on-scroll-up = "${scripts.ddcutil-up}";
    on-scroll-down = "${scripts.ddcutil-down}";
    on-click = "${scripts.ddcutil-bright}";
    on-click-right = "${scripts.ddcutil-dark}";
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
    on-scroll-up = "${scripts.brightnessctl} s +1%";
    on-scroll-down = "${scripts.brightnessctl} s 1%-";
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
    on-click = "${scripts.volumectl} toggle-mute";
    reverse-scrolling = true;
    reverse-mouse-scrolling = false;
    # on-scroll-up = "${scripts.volumectl} up";
    # on-scroll-down = "${scripts.volumectl} down";
  };
  "pulseaudio#microphone" = {
    tooltip = false;
    format = "{format_source}";
    format-source = "󰍬 {volume}%";
    format-source-muted = "󰍭 Mute";
    on-click = "${scripts.volumectl} -m toggle-mute";
    # on-scroll-up = "${scripts.volumectl} -m up 1";
    # on-scroll-down = "${scripts.volumectl} -m down 1";
    reverse-scrolling = true;
    reverse-mouse-scrolling = false;
    on-scroll-up = "${pkgs.pamixer}/bin/pamixer --default-source -i 1";
    on-scroll-down = "${pkgs.pamixer}/bin/pamixer --default-source -d 1";
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
