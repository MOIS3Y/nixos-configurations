# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# Configures libvirtd and docker.

{ config, ... }:
let
  cfg = config.host.virtualisation;
in
{
  virtualisation.libvirtd = {
    enable = cfg.libvirtd.enable;
  };
  virtualisation.docker = {
    enable = cfg.docker.enable;
  };
}
