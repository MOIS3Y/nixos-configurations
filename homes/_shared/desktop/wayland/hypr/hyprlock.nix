# █░█ █▄█ █▀█ █▀█ █░░ █▀█ █▀▀ █▄▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  programs.hyprlock = {
    enable = true;
    settings = with config.colorScheme.palette; {
      background = [
        {
          monitor = "";
          color = "rgb(${base00})";
          path = "${config.desktop.assets.background}";
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
          outer_color = "rgb(${base02})";
          inner_color = "rgb(${base01})";
          font_color = "rgb(${base05})";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = "-1"; # -1 means complete rounding (circle/oval)
          check_color = "rgb(${base0E})";
          fail_color = "rgb(${base08})";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 500;
          capslock_color = "rgb(${base0A})";
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
          color = "rgb(${base05})";
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
          color = "rgb(${base05})";
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
          color = "rgb(${base05})";
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
          path = "${config.desktop.assets.icons}/hyprlock/${config.colorScheme.name}.png";
          size = 270; # lesser side if not 1:1 ratio
          rounding = "-1";
          border_size = 3;
          border_color = "rgb(${base02})";
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
