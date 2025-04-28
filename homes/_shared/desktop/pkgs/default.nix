# █░█ █▀ █▀▀ █▀█   █▀█ ▄▀█ █▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄   █▀▀ █▀█ █▄▄ █░█ █▀█ █▄█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./development.nix
    ./media.nix
    ./network.nix
    ./society.nix
    ./wine.nix
    ./x11.nix
  ];
}