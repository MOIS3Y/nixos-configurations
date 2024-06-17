# █▀ █░█ █▀▀ █░░ █░░ █▀ ▀
# ▄█ █▀█ ██▄ █▄▄ █▄▄ ▄█ ▄
# -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  environment.shells = [
    pkgs.bash
    pkgs.zsh
  ];
}
