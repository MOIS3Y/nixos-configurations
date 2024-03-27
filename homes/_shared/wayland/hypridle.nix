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
    notify-send = "${pkgs.libnotify}/bin/notify-send";
    swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  in {
  
  imports = [
    inputs.hypridle.homeManagerModules.hypridle
  ];

  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    lockCmd = "${swaylock}";
    # unlockCmd = "${notify-send} 'unlock!'";
    # beforeSleepCmd = "${notify-send} 'Zzz'";
    afterSleepCmd = "${swaylock}";
    # ignoreDbusInhibit = false;  # ? false is default value

    listeners = [
      {
        timeout = 600;
        onTimeout = "${notify-send} 'The device will soon be blocked due to inactivity!'";
        onResume = "${notify-send} 'Welcome back!'";
      }
      {
        timeout = 660;
        onTimeout = "${swaylock}";
      }
      {
        timeout = 720;
        onTimeout = "${hyprctl} dispatch dpms off";
        onResume = "${hyprctl} dispatch dpms on";
      }
      {
        timeout = 900;
        onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
      }
      # add more listeners hrere ...
    ];
  };
}
