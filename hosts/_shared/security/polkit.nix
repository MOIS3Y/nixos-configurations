# █▀█ █▀█ █░░ █▄▀ █ ▀█▀ ▀
# █▀▀ █▄█ █▄▄ █░█ █ ░█░ ▄
# -- -- -- -- -- -- -- --

{ config, pkgs, ...}: {
  security.polkit = {
    enable = true;
  };
}
