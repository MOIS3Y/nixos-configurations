# ▀▄▀ █▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ ▄█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, utils, ... }: with utils; {
  lock = ''
    ${i3lock-run} \
    -s ${config.colorScheme.name} \
    -f Ubuntu
  '';
  dpms-off = "${xset} s off s noblank -dpms";
}
