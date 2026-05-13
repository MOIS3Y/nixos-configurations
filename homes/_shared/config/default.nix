# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ ▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█ ▄
# -- -- -- -- -- -- -- --
# Main entry point for user environment configurations (GTK, Qt, XDG, etc.).

{ ... }:
{
  imports = [
    ./dconf.nix
    ./gtk.nix
    ./pointer-cursor.nix
    ./qt.nix
    ./xdg.nix
  ];
}
