# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    arandr
    flameshot
    xkb-switch
    # Extra-pkgs:
    extra.i3lock-run
    extra.xidlehook-caffeine
  ];
}
