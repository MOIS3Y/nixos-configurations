# █░█░█ █░░ █▀█ █▀▀ █▀█ █░█ ▀█▀ ▀
# ▀▄▀▄▀ █▄▄ █▄█ █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, ...}:
  let
    wlogoutIconsDir = "${pkgs.wlogout}/share/wlogout/icons";
    wlogoutHyprExit = with pkgs; writeShellScriptBin "hypr-exit" ''
      sleep 1
      killall -9 Hyprland sleep 2
    '';
    swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
  in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "sleep 0.5; ${swaylock}";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "sleep 1; systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl kill-session self";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "sleep 1; systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "sleep 1; systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      * {
          font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          background-image: none;
          transition: 20ms;
          box-shadow: none;
          }
      window {
        background-color: rgba(12, 12, 12, 0.1);
      }
      button {
        color: #${config.colorScheme.palette.base05};
        font-size:20px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-style: solid;
        background-color: rgba(12, 12, 12, 0.3);
        border: 3px solid #${config.colorScheme.palette.base05};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }
      button:focus,
      button:active,
      button:hover {
          color: #${config.colorScheme.palette.base0D};
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid #${config.colorScheme.palette.base0D};
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
