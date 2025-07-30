# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./automounts.nix
    ./mounts.nix
    ./services.nix
  ];
}
