# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./automounts.nix
    ./mounts.nix
    ./services.nix
    ./user-services.nix
  ];
}
