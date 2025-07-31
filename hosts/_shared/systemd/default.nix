# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./automounts.nix
    ./mounts.nix
    ./user-services.nix
  ];
}
