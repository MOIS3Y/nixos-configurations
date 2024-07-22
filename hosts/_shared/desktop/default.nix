# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./dm
    ./fixes
    ./games
    ./gnome
    ./laptop
    ./pkgs
    ./services
    ./wayland
    ./xorg
  ];
}
