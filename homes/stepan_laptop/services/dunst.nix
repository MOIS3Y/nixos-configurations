# █▀▄ █░█ █▄░█ █▀ ▀█▀ ▀
# █▄▀ █▄█ █░▀█ ▄█ ░█░ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/services/dunst.nix
  ];
}
