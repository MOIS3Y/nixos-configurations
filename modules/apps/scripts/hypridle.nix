# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ config, pkgs, utils, ... }: with utils; rec {
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
      ${paplay} ${config.assets.sounds}/alarm/answer-quickly.mp3
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
  suspend = "${systemctl} suspend";
}