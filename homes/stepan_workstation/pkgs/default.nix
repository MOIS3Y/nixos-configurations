# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/pkgs/common.nix
    ../../_shared/pkgs/development.nix
    ../../_shared/pkgs/game.nix
    ../../_shared/pkgs/managment.nix
    ../../_shared/pkgs/media.nix
    ../../_shared/pkgs/network.nix
    ../../_shared/pkgs/society.nix
    ../../_shared/pkgs/wine.nix
  ];
}
