# █▀█ █▀█ █▀▀ █▀ █▀▀ ▀█▀ █▀ ▀
# █▀▀ █▀▄ ██▄ ▄█ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- --

{
  workstation = {
    enable = true;
    laptop.enable = false;
    xorg.enable = false;
    wayland.enable = true;
    games.enable = true;
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
  };
  laptop = {
    enable = true;
    laptop.enable = true;
    xorg.enable = false;
    wayland.enable = true;
    games.enable = true;
    devices = {
      monitors = [
        {
          name = "eDP-1";  # primary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 0;
          y =0;
          enabled = true;
        }
        {
          name = "HDMI-A-1";  # secondary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 1920;  # connected to the right of eDP-1
          y =0;
          enabled = true;      
        }
      ];
      keyboard = {
        name = "at-translated-set-2-keyboard";
        kb_layout = "us,ru";
        kb_model = "pc104";
        kb_options = "grp:alt_shift_toggle";
      };
    };
  };
  # add more presets here ...
}
