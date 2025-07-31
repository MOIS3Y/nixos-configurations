# ▀▄▀ ▄█ ▄█ ▀
# █░█ ░█ ░█ ▄
# -- -- -- --

{ config, pkgs, lib, ... }: {
  home.packages = lib.optionals config.desktop.xorg.enable [
    pkgs.arandr
    pkgs.flameshot
    pkgs.xkb-switch
    # Extra-pkgs:
    pkgs.extra.i3lock-run
    pkgs.extra.xidlehook-caffeine
  ];
}
