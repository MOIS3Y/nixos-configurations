# █▀▀ █▀█ █▀▄▀█ █▀▄▀█ █▀█ █▄░█ ▀
# █▄▄ █▄█ █░▀░█ █░▀░█ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ./dm.nix
    ./gnome.nix
    ./services.nix
  ];
}
