# █░█ █▄█ █▀█ █▀█ █░░ █▀█ █▀▀ █▄▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: let
  cfg = config.desktop.wayland;
  inherit (config.desktop.assets)
    icons
    images;
  inherit (config.colorScheme)
    palette;
  in {
  programs.hyprlock = {
    enable = cfg.enable;
    package = pkgs.hyprlock;
    settings = {
      background = [
        {
          monitor = "";
          color = "rgb(${palette.base00})";
          path = "${images.background}";
          blur_size = 4;
          blur_passes = 3;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "270, 50" ;
          outline_thickness = 3;
          dots_size = "0.35"; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = "0.25"; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          dots_rounding = "-1";
          outer_color = "rgb(${palette.base02})";
          inner_color = "rgb(${palette.base01})";
          font_color = "rgb(${palette.base05})";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = "-1"; # -1 means complete rounding (circle/oval)
          check_color = "rgb(${palette.base0E})";
          fail_color = "rgb(${palette.base08})";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 500;
          capslock_color = "rgb(${palette.base0A})";
          numlock_color = "-1";
          bothlock_color = "-1";
          invert_numlock = false;
          swap_font_color = false;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          #time
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"'';
          color = "rgb(${palette.base05})";
          font_size = 72;
          font_family = "Ubuntu";
          position = "-100, 50";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          #username
          monitor = "";
          text = "$DESC";
          color = "rgb(${palette.base05})";
          font_size = 22;
          font_family = "Ubuntu";
          position = "-100, 180";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          #language
          monitor = "";
          text = "$LAYOUT";
          color = "rgb(${palette.base05})";
          font_size = 13;
          font_family = "Ubuntu";
          position = "-100, 220";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
      image = [
        {
          monitor = "";
          path = "${icons}/hyprlock/${config.colorScheme.name}.png";
          size = 270; # lesser side if not 1:1 ratio
          rounding = "-1";
          border_size = 3;
          border_color = "rgb(${palette.base02})";
          rotate = 0;
          reload_time = "-1";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
