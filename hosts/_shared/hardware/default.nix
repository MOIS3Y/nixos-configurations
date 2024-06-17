# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./bluetooth.nix
    ./intel.nix
    ./opengl.nix
    ./openrgb.nix
    ./xpadneo.nix
  ];
}
