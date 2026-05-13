# █▀▄▀█ ▄▀█ █▄░█ █▀▀ █▀█ █░█ █░█ █▀▄ ▀
# █░▀░█ █▀█ █░▀█ █▄█ █▄█ █▀█ █▄█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- --
# Configures MangoHud, an OpenGL/Vulkan overlay for monitoring performance.

{ config, lib, ... }:
{
  programs.mangohud = {
    enable = lib.mkDefault config.desktop.games.enable;
  };
}
