# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ config, pkgs, ... }: let
  cfg = config.desktop.wayland;
  inherit (config.desktop.scripts.hypridle)
    dpms-off
    dpms-on
    lock-session
    lock-resume
    kill-notify
    send-notify
    smart-hyprlock
    suspend;
  in {
  services.hypridle = {
    enable = cfg.enable;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "${smart-hyprlock}";
        before_sleep_cmd = "${lock-session}";
        after_sleep_cmd = "${dpms-on}";
      };
      listener = [
        {
          timeout = 540;
          on-timeout = "${send-notify}";
          on-resume = "${kill-notify}";
        }
        {
          timeout = 600;
          on-timeout = "${dpms-off}";
          on-resume = "${lock-resume}";
        }
        {
          timeout = 900;
          on-timeout = "${suspend}";
        }
      ];
    };
  };
}
