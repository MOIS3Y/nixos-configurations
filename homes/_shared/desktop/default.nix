# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./config
    ./pkgs
    ./programs
    ./services
    ./wayland
    ./xorg
  ];
}
