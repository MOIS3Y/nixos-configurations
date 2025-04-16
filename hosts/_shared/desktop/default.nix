# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./dm
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
