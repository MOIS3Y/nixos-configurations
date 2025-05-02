# █▀ ▀█▀ █▄█ █░░ █▀▀ █▀ ▀
# ▄█ ░█░ ░█░ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- --

{ config, ... }: let
    nixLogo = builtins.fetchurl rec {
      name = "Logo-${sha256}.svg";
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/56b7a5788005a3eaecb5298f0dbed0f7d1573abc/logo/nix-snowflake-colours.svg";
      sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
    };
    inherit (config.colorScheme)
      variant
      palette;
  in {
  primary = ''
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
}
