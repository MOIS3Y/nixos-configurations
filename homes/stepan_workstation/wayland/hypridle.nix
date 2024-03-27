# █░█ █▄█ █▀█ █▀█ █ █▀▄ █░░ █▀▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ █ █▄▀ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- - -- --

{ config, pkgs, ... }:{
  imports = [
    ../../_shared/wayland/hypridle.nix
  ];
}
