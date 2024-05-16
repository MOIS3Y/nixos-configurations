# █▀ █░█░█ ▄▀█ █▀█ █▀█ █▄█ ▀
# ▄█ ▀▄▀▄▀ █▀█ █▀▀ █▀▀ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/wayland/swappy.nix
  ];
  earlyExit = true;
}
