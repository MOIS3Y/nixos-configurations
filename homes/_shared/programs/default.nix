# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./ssh
    
    ./git.nix
    ./helix.nix
    ./lf.nix
    ./lsd.nix
    ./nvchad.nix
    ./zsh.nix
  ];
}
