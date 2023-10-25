# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./eww.nix
    ./git.nix
    ./lf.nix
    ./lsd.nix
    ./rofi.nix
    ./ssh.nix
    ./zsh.nix
  ];
}
