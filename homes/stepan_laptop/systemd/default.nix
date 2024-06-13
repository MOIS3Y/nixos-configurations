# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/systemd/tray-target.nix
  ];
}
