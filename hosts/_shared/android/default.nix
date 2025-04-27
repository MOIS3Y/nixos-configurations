# ▄▀█ █▄░█ █▀▄ █▀█ █▀█ █ █▀▄ ▀
# █▀█ █░▀█ █▄▀ █▀▄ █▄█ █ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./environment
    ./nix
    ./programs
    ./services
    ./terminal
    ./user
  ]; 
}
