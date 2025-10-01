# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./amdgpu.nix
    ./bluetooth.nix
    ./graphics.nix
    ./xone.nix
    ./xpadneo.nix
  ];
}
