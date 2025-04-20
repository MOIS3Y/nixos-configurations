# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./dm
    ./games
    ./gnome
    ./pkgs
    ./programs
    ./services
    ./wayland
    ./xorg
  ];
}