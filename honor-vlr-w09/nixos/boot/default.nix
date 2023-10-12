# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -----------------
{config, pkgs, ...}: {
  imports = [
    ./loader.nix
    ./plymouth.nix
  ];
}
