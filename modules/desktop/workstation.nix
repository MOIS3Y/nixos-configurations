# █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

# This module contains configuration for desktop-workstation
# These values ​​are available across both NixOS and HM configurations.
# The module can be considered as a upper level module.
# If you need to override the values, you should do it here
# If necessary override values, this is the best place to do this.
# Although the values ​​can be changed in the configuration of each host or hm.

{ config, pkgs, lib, ... }: let 
  inherit (config.desktop)
    utils;
  in {
    imports = [
    ./.
  ];
  desktop = {
    enable = true;
    laptop.enable = false;
    xorg.enable = false;
    wayland.enable = true;
    games = {
      enable = true;
      # TODO: add attrs here after split games module
    };
    devices = {
      monitors = [
        {
          name = "DP-1";  # primary
          width = 1920;
          height = 1080;
          refreshRate = 144;
          x = 0;
          y =0;
          enabled = true;
        }
        {
          name = "HDMI-A-1";  # secondary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 1920;  # connected to the right of DP-1
          y =0;
          enabled = true;      
        }
      ];
      keyboard = {
        name = "logitech-k370s/k375s";
        kb_layout = "us,ru";
        kb_model = "pc104";
        kb_options = "grp:alt_shift_toggle";
      };
    };
    apps = with utils; {
      terminal = kitty;
      spare-terminal = alacritty;
      browser = firefox;
      filemanager = nautilus;
      launcher = wofi;
      lockscreen = hyprlock;
      visual-text-editor = vscode;
    };
  };
}
