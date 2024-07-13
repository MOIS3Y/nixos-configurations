# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ ▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█ ▄
# -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: {
  imports = [
    ./dconf.nix
    ./gtk.nix
    ./pointer-cursor.nix
    ./qt.nix
    ./xdg.nix
  ];
}
