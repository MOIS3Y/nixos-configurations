# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ inputs, config, pkgs, ... }:
  let
    hypridle-suspend = with pkgs; writeShellScript "hypridle-suspend" ''
      # TODO: add func use pipwire
      # ${pipewire}/bin/pw-cli i all 2>&1 | ${ripgrep}/bin/rg running -q
      # ? pactl check running sink:
      ${pulseaudio}/bin/pactl list sinks short | rg RUNNING
      # ? only suspend if audio isn't running
      if [ $? == 1 ]; then
        ${systemd}/bin/systemctl suspend
      fi
    '';
    pgrep = "${pkgs.procps}/bin/pgrep";
    notify-send = "${pkgs.libnotify}/bin/notify-send";
    swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  in {
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "${pgrep} swaylock || ${swaylock}";
        # unlock_cmd = "${notify-send} 'unlock!'";
        # before_sleep_cmd = "${notify-send} 'Zzz'";
        after_sleep_cmd = "${swaylock}";
        # ignore_dbus_inhibit = false;  # ? false is default value
      };
      listener = [
        {
          timeout = 600;
          on-timeout = "${notify-send} 'The device will soon be blocked due to inactivity!'";
          onResume = "${notify-send} 'Welcome back!'";
        }
        {
          timeout = 660;
          on-timeout = "${swaylock}";
        }
        {
          timeout = 720;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
        {
          timeout = 900;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
        # add more listeners hrere ...
      ];
    };
  };
}
