# ▀▄▀ █▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ ▄█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/xorg/xss-lock.nix
  ];
}