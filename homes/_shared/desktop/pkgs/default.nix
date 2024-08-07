# █░█ █▀ █▀▀ █▀█   █▀█ ▄▀█ █▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄   █▀▀ █▀█ █▄▄ █░█ █▀█ █▄█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./development.nix
    ./media.nix
    ./network.nix
    ./society.nix
    ./wine.nix
  ];
}
