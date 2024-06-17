# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {

  imports = [
    ../../_shared/systemd/amd.nix
    ./automounts.nix
    ./user-services.nix
    ./mounts.nix
  ];
}
