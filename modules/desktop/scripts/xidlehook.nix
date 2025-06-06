# ▀▄▀ █ █▀▄ █░░ █▀▀ █░█ █▀█ █▀█ █▄▀ ▀
# █░█ █ █▄▀ █▄▄ ██▄ █▀█ █▄█ █▄█ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, ... }: let
  inherit (config.desktop.utils)
    awk
    dunstify
    i3lock-run
    systemctl
    xrandr; 
  in {
  desktop.scripts.xidlehook = {
    primary-display = "${xrandr} | ${awk} '/ primary/{print $1}'";
    notify = ''
      ${dunstify} \
        "Power" "Computer will suspend very soon because of inactivity" \
        -u normal
      '';
    lock = ''
      ${i3lock-run} \
      -s ${config.colorScheme.name} \
      -f Ubuntu
      '';
    suspend = "${systemctl} suspend";
  };
}
