# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# Configures libvirtd and docker.

{ lib, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = lib.mkDefault true;
    };
    docker = {
      enable = lib.mkDefault true;
      enableOnBoot = lib.mkDefault false;
    };
  };
}
