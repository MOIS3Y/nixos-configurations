# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./games
    ./gnome
    ./laptop
    ./pkgs
    ./programs
    ./services
    ./wayland
    ./xorg
  ];
}
