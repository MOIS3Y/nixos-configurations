# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./ssh
    
    ./git.nix
    ./helix.nix
    ./khal.nix
    ./lf.nix
    ./lsd.nix
    ./nvchad.nix
    ./zsh.nix
  ];
}
