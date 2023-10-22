# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {

  imports = [
    ./automounts.nix
    ./user-services.nix
    ./mounts.nix
  ];
}
