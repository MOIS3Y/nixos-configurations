# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./ssh.nix
    ./steam.nix
    ./zsh.nix
  ];
}
