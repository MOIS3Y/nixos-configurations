# █░█░█ █░░ █▀█ █▀▀ █▀█ █░█ ▀█▀ ▀
# ▀▄▀▄▀ █▄▄ █▄█ █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }:{
  imports = [
    ../../_shared/wayland/wlogout.nix
  ];
}
