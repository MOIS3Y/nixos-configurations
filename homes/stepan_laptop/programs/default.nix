# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./helix.nix
    ./khal.nix
    ./lf.nix
    ./lsd.nix
    ./ssh.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
