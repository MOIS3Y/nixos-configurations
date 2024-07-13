# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  services.hypridle = with config.apps.scripts.hypridle; {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "${smart-hyprlock}";
        after_sleep_cmd = "${smart-hyprlock}";
      };
      listener = [
        {
          timeout = 600;
          on-timeout = "${send-notify}";
          on-resume = "${kill-notify}";
        }
        {
          timeout = 660;
          on-timeout = "${smart-hyprlock}";
        }
        {
          timeout = 720;
          on-timeout = "${dpms-off}";
          on-resume = "${dpms-on}";
        }
        {
          timeout = 900;
          on-timeout = "${suspend}";
        }
        # add more listeners hrere ...
      ];
    };
  };
}
