# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./ssh.nix
    # ./xss-lock.nix
    ./zsh.nix
  ];
}
