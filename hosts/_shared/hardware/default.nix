# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./bluetooth.nix
    ./graphics.nix
    ./intel.nix
    ./openrgb.nix
    ./xpadneo.nix
  ];
}
