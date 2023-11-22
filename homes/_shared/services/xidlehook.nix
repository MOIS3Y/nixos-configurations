# ▀▄▀ █ █▀▄ █░░ █▀▀ █░█ █▀█ █▀█ █▄▀ ▀
# █░█ █ █▄▀ █▄▄ ██▄ █▀█ █▄█ █▄█ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  services.xidlehook = {
    enable = true;
    detect-sleep = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    environment = {
      PRIMARY_DISPLAY = "$(xrandr | awk '/ primary/{print $1}')";
    };
    timers = [
      {
        delay = 600;
        command = with pkgs; ''
          ${dunst}/bin/dunstify \
            "Power" "Computer will suspend very soon because of inactivity" \
            -u normal
        '';
      }
      {
        delay = 10;
        command = with pkgs; ''
          ${extrapkgs.i3lock-run}/bin/i3lock-run -s catppuccin_mocha -f Inter
        '';
      }
      {
        delay = 60;
        command = "systemctl suspend";
      }
    ];
  };
}
