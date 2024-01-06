# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{config, pkgs, ...}: {

  imports = [
    ./loader.nix
    ./raid.nix
  ];
}
