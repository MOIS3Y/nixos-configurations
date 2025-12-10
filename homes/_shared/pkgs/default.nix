# █░█ █▀ █▀▀ █▀█   █▀█ ▄▀█ █▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄   █▀▀ █▀█ █▄▄ █░█ █▀█ █▄█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./development.nix
    ./media.nix
    ./network.nix
    ./security.nix
    ./society.nix
    ./wine.nix
    ./x11.nix
  ];
}
