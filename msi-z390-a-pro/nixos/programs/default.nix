# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, ...}: {
  imports = [
    ./ssh.nix
    ./steam.nix
    ./xss-lock.nix
    ./zsh.nix
  ];
}
