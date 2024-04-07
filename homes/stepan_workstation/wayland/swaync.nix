# █▀ █░█░█ ▄▀█ █▄█ █▄░█ █▀▀ ▀
# ▄█ ▀▄▀▄▀ █▀█ ░█░ █░▀█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }:{
  imports = [
    ../../_shared/wayland/swaync.nix
  ];
}
