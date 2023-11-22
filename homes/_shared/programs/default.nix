# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./eww.nix
    ./helix.nix
    ./lf.nix
    ./lsd.nix
    ./rofi.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
