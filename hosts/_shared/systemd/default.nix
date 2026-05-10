# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./automounts.nix
    ./mounts.nix
    ./services.nix
    ./tmpfiles.nix
    ./user-services.nix
  ];
}
