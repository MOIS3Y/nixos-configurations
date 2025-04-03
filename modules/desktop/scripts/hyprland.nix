# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: let
  inherit (config.desktop.utils)
    grim
    paplay
    pgrep
    pkill
    slurp
    swappy
    lightctl
    volumectl;
  inherit (config.desktop.assets.sounds)
    open-beep
    volume-beep
    toggle-beep; 
  in {
  desktop.scripts.hyprland = {
    screenshot = pkgs.writeShellScript "hyprland-screenshot.sh" ''
      ${grim} -g "$(${slurp} -w 0)" - | ${swappy} -f -
    '';
    startup = pkgs.writeShellScript "hyprland-startup.sh" ''
      # greet sound
      ${paplay} ${open-beep} &
      # add startup apps here ...
    '';
    launcher-toggle = pkgs.writeShellScript "hyprland-launcher-toggle.sh" ''
      if ${pgrep} -f "${config.desktop.apps.launcher}" > /dev/null 2>&1; then
        ${pkill} -f "${config.desktop.apps.launcher}"
      else
        ${config.desktop.apps.launcher}
      fi
    '';
    brightness-up = "${lightctl} up";
    brightness-down = "${lightctl} down";
    volume-up = "${volumectl} -u up & ${paplay} ${volume-beep}";
    volume-down = "${volumectl} -u down & ${paplay} ${volume-beep}"; 
    volume-mute = "${volumectl} toggle-mute & ${paplay} ${toggle-beep}";
    mic-mute = "${volumectl} -m toggle-mute & ${paplay} ${toggle-beep}";
  };
}
