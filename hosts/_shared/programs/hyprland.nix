# █░█ █▄█ █▀█ █▀█ █░░ ▄▀█ █▄░█ █▀▄ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▄▄ █▀█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  programs.hyprland = {
    enable = builtins.elem "hyprland" config.desktop.wayland.compositors;
    # ? waiting fix uwsm with sddm
    # ? see: https://github.com/Vladimir-csp/uwsm/issues/92
    withUWSM  = false;
  };
}
