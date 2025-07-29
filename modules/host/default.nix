# █░█ █▀█ █▀ ▀█▀ ▀
# █▀█ █▄█ ▄█ ░█░ ▄
# -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./boot.nix
    ./flake-path.nix
    ./hardware.nix
    ./users.nix
    ./virtualisation.nix
  ];
}
