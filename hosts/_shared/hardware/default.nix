# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./amdgpu.nix
    ./bluetooth.nix
    ./graphics.nix
    ./openrazer.nix
    ./xone.nix
    ./xpadneo.nix
  ];
}
