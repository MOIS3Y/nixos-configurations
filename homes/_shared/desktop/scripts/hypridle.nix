# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ config, pkgs, ... }: with config.desktop.utils; rec {
  send-notify = pkgs.writeShellScript "hypridle-send-notify.sh" ''
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
      ${paplay} ${config.desktop.assets.sounds.warning-notification} &
      idle_msg
    }

    # RUN IT:
    main
  '';
  kill-notify = pkgs.writeShellScript "hypridle-kill-notify.sh" ''
    killer() {
      if ${pgrep} -f "${send-notify}" > /dev/null; then
        ${pkill} -f "${send-notify}"
      fi
    }

    main() {
      killer
    }

    # RUN IT:
    main
  '';
  smart-hyprlock = "${pgrep} hyprlock || ${hyprlock}";
  dpms-off = "${hyprctl} dispatch dpms off";
  dpms-on = "${hyprctl} dispatch dpms on";
  lock-session = "${loginctl} lock-session";
  suspend = "${systemctl} suspend";
  lock-resume = pkgs.writeShellScript "hypridle-lock-resume.sh" ''
    # This is a hack.
    # I can't pass hyprlock as on-timeout because it resets the timer
    # The problem is relevant with git version of Hyprland and hyprlock
    ${hyprctl} dispatch dpms on 2>&1 > /tmp/lock-resume.log
    ${smart-hyprlock}
  '';
}
