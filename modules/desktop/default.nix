# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./module.nix
  ];

  # ? current desktop config for all desktop devices:
  desktop = {
    xorg.enable = false;  # Now I use only wayland
    wayland.enable = true;
    games.enable = true;
  };
}
