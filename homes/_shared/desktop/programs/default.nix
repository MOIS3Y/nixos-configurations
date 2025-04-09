# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./eww.nix
    ./kitty.nix
    ./lf.nix
    ./mangohud.nix
    ./mellowplayer.nix
    ./vscode.nix
    ./wezterm.nix
  ];
}
