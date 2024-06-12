# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
    imports = [
        ./bluetooth.nix
        ./opengl.nix
        ./openrgb.nix
        ./xpadneo.nix
    ];
}
