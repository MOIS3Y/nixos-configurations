# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: with config.desktop.utils; {
  screenshot = pkgs.writeShellScript "hyprland-screenshot.sh" ''
    ${grim} -g "$(${slurp} -w 0)" - | ${swappy} -f -
  '';
  startup = pkgs.writeShellScript "hyprland-startup.sh" ''
    # add startup apps here ...
  '';
  launcher-toggle = pkgs.writeShellScript "hyprland-launcher-toggle.sh" ''
    # TODO: automatic launcher detection
    ${pgrep} wofi >/dev/null 2>&1 && ${pkill} wofi || ${wofi} --show drun
  '';
  brightness-up = "${lightctl} up";
  brightness-down = "${lightctl} down";
  volume-up = "${volumectl} -u up";
  volume-down = "${volumectl} -u down";
  volume-mute = "${volumectl} toggle-mute";
  mic-mute = "${volumectl} -m toggle-mute";
}
