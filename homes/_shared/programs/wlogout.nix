# █░█░█ █░░ █▀█ █▀▀ █▀█ █░█ ▀█▀ ▀
# ▀▄▀▄▀ █▄▄ █▄█ █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: let
  inherit (config.colorScheme)
    name
    palette
    variant;
  inherit (config.desktop)
    scripts;
  in {
  programs.wlogout = {
    enable = lib.mkDefault config.desktop.wayland.enable;
    layout = [
      {
        label = "lock";
        action = "${scripts.wlogout.lock}";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "${scripts.wlogout.hibernate}";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "${scripts.wlogout.logout}";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "${scripts.wlogout.shutdown}";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "${scripts.wlogout.suspend}";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "${scripts.wlogout.reboot}";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = let
      wlogoutIconsDir = "${config.desktop.assets.icons}/wlogout/${name}";
      dark01 = "rgba(12, 12, 12, 0.1)";
      light01 = "rgba(255, 255, 255, 0.1)";
      dark02 = "rgba(12, 12, 12, 0.2)";
      light02 = "rgba(255, 255, 255, 0.2)";
      dark04 = "rgba(12, 12, 12, 0.4)";
      light04 = "rgba(255, 255, 255, 0.4)";

      window-bg-color = "${if variant == "dark" then dark01 else light01}";
      btn-bg-color = "${if variant == "dark" then dark02 else light02}";
      btn-focus-color = "${if variant == "dark" then dark04 else light04}"; 
    in ''
      * {
          font-family: Ubuntu, Roboto, Inter, Helvetica, Arial, sans-serif;
          background-image: none;
          transition: 20ms;
          box-shadow: none;
          }
      window {
        background-color: ${window-bg-color};
      }
      button {
        color: #${palette.base05};
        font-size:20px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-style: solid;
        background-color: ${btn-bg-color};
        border: 3px solid #${palette.base05};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }
      button:focus,
      button:active,
      button:hover {
        color: #${palette.base0D};
        background-color: ${btn-focus-color};
        border: 3px solid #${palette.base0D};
      }
      /* 
      ----------------------------------------------------- 
      Buttons
      ----------------------------------------------------- 
      */
      #lock {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${wlogoutIconsDir}/lock.png"));
      }
      #logout {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${wlogoutIconsDir}/logout.png"));
      }
      #suspend {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${wlogoutIconsDir}/suspend.png"));
      }
      #hibernate {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${wlogoutIconsDir}/hibernate.png"));
      }
      #shutdown {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${wlogoutIconsDir}/shutdown.png"));
      }
      #reboot {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("${wlogoutIconsDir}/reboot.png"));
      }
    '';
  };
}
