# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./apps
    ./config
    ./pkgs
    ./programs
    ./scripts
    ./services
    ./utils
    ./wayland
    ./xorg
  ];
}
