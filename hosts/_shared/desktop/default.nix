# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./games
    ./gnome
    ./pkgs
    ./programs
    ./services
    ./wayland
    ./xorg
  ];
}