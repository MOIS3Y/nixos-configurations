# ▀▄▀ █▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ ▄█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, ... }: let
  inherit (config.desktop.utils)
    i3lock-run
    xset
    xss-lock;
  in {
  desktop.scripts.xss-lock = {
    lock = ''
      ${xss-lock} --session ''${XDG_SESSION_ID} \
      -- ${i3lock-run} -s ${config.colorScheme.name} -f Ubuntu
    '';
    dpms-off = "${xset} s off s noblank -dpms";
  };
}
