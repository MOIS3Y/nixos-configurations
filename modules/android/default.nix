# ▄▀█ █▄░█ █▀▄ █▀█ █▀█ █ █▀▄ ▀
# █▀█ █░▀█ █▄▀ █▀▄ █▄█ █ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -
# Main entry point for Android specific configurations.

{ ... }:
{
  imports = [
    ./programs.nix
    ./services.nix
    ./terminal.nix
  ];
}
