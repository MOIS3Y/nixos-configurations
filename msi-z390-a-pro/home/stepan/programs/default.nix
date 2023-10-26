# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./eww.nix
    ./git.nix
    ./lf.nix
    ./lsd.nix
    ./mangohud.nix
    ./rofi.nix
    ./ssh.nix
    ./zsh.nix
  ];
}
