# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./ssh
    
    ./git.nix
    ./helix.nix
    ./htop.nix
    ./lf.nix
    ./lsd.nix
    ./nvchad.nix
    ./zsh.nix
  ];
}
