# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ ▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█ ▄
# -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./gtk.nix
    ./pointer-cursor.nix
    ./qt.nix
    ./xdg.nix
  ];
}
