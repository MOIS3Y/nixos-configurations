# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ config, pkgs, lib, ... }: let
  inherit (config.desktop)
    scripts;
  in {
  services.hypridle = {
    enable = lib.mkDefault config.wayland.windowManager.hyprland.enable;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "${scripts.hypridle.smart-hyprlock}";
        before_sleep_cmd = "${scripts.hypridle.lock-session}";
        after_sleep_cmd = "${scripts.hypridle.dpms-on}";
      };
      listener = [
        {
          timeout = 540;
          on-timeout = "${scripts.hypridle.send-notify}";
          on-resume = "${scripts.hypridle.kill-notify}";
        }
        {
          timeout = 600;
          on-timeout = "${scripts.hypridle.dpms-off}";
          on-resume = "${scripts.hypridle.lock-resume}";
        }
        {
          timeout = 900;
          on-timeout = "${scripts.hypridle.suspend}";
        }
      ];
    };
  };
}
