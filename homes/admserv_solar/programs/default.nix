# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/programs/git.nix
    ../../_shared/programs/lf.nix
    ../../_shared/programs/lsd.nix
    ../../_shared/programs/nvchad.nix
    ../../_shared/programs/zsh.nix
  ];
}
