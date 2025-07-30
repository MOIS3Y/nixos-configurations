# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, ... }: let
  inherit (config.desktop)
    wayland;
in {
  programs.hyprland = {
    enable = wayland.enable && (builtins.elem "hyprland" wayland.compositors);
    # ? waiting fix uwsm with sddm
    # ? see: https://github.com/Vladimir-csp/uwsm/issues/92
    withUWSM = false;
  };
}
