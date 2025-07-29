# █▀ ▀█▀ █▀▀ ▄▀█ █▀▄▀█ ▀
# ▄█ ░█░ ██▄ █▀█ █░▀░█ ▄
# -- -- -- -- -- -- -- -

{ config, lib, ... }: {
  programs.steam = {
    enable = lib.mkIf config.desktop.games.enable true;
    extest.enable = lib.mkIf config.desktop.wayland.enable true;
    gamescopeSession = {
      enable = true;
    };
  };
}
