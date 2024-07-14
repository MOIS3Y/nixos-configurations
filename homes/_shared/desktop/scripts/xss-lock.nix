# ▀▄▀ █▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ ▄█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: with config.desktop.utils; {
  lock = ''
    ${xss-lock} --session ''${XDG_SESSION_ID} \
    -- ${i3lock-run} -s ${config.colorScheme.name} -f Ubuntu
  '';
  dpms-off = "${xset} s off s noblank -dpms";
}
