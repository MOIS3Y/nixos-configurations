# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./git.nix
    ./helix.nix
    ./khal.nix
    ./lf.nix
    ./lsd.nix
    ./nvchad.nix
    ./ssh.nix
    ./zsh.nix
  ];
}
