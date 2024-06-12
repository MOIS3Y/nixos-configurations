# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, ...}: {
  imports = [
    ../../_shared/programs/hyprland.nix
    ../../_shared/programs/ssh.nix
    ../../_shared/programs/steam.nix
    ../../_shared/programs/zsh.nix
  ];
}
