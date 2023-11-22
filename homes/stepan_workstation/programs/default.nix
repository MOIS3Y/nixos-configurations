# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./eww.nix
    ./git.nix
    ./helix.nix
    ./khal.nix
    ./lf.nix
    ./lsd.nix
    ./mangohud.nix
    ./rofi.nix
    ./ssh.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
