# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ inputs, config, pkgs, ... }:
  let
    # bin tools:
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
    notify-send = "${pkgs.libnotify}/bin/notify-send";
    paplay = "${pkgs.pulseaudio}/bin/paplay";
    pgrep = "${pkgs.procps}/bin/pgrep";
    pkill = "${pkgs.procps}/bin/pkill";
    seq = "${pkgs.coreutils}/bin/seq";
    sleep = "${pkgs.coreutils}/bin/sleep";
    swaylock = "${pkgs.swaylock-effects}/bin/swaylock";

    # scripts:
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
    hypridle-notify = with pkgs; writeShellScript "hypridle-notify" ''
      print_msg() {
        printf "\n"
        printf "The device will soon \n"
        printf "be blocked due to inactivity!"
      }

      idle_msg() {
        ${seq} 100 | while read -r number; do
          ${notify-send} \
            -a Hyprland \
            -i display \
            -h int:value:"$number" \
            -h string:synchronous:my-progress "$(print_msg)" \
            -t 888
          ${sleep} 0.6  # around 1 minute
        done
      }

      main() {
        ${paplay} ${pkgs.extrapkgs.assets4nix}/share/sounds/alarm/answer-quickly.mp3
        idle_msg
      }

      # RUN IT:
      main
    '';
    hypridle-notify-killer = with pkgs; writeShellScript "hypridle-notify-killer" ''
      killer() {
        if ${pgrep} -f "${hypridle-notify}" > /dev/null; then
          ${pkill} -f "${hypridle-notify}"
        fi
      }

      main() {
        killer
      }

      # RUN IT:
      main
    '';
  in {
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    settings = {
      general = {
        lock_cmd = "${pgrep} hyprlock || ${hyprlock}";
        # unlock_cmd = "${notify-send} 'unlock!'";
        # before_sleep_cmd = "${notify-send} 'Zzz'";
        after_sleep_cmd = "${pgrep} hyprlock || ${hyprlock}";
        # ignore_dbus_inhibit = false;  # ? false is default value
      };
      listener = [
        {
          timeout = 600;
          on-timeout = "${hypridle-notify}";
          on-resume = "${hypridle-notify-killer}";
        }
        {
          timeout = 660;
          on-timeout = "${hyprlock}";
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
