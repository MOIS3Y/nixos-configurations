# █▀ ▀█▀ █▀▀ ▄▀█ █▀▄▀█ ▀
# ▄█ ░█░ ██▄ █▀█ █░▀░█ ▄
# -- -- -- -- -- -- -- -

{ config, ... }: {
  programs.steam = {
    enable = config.desktop.games.enable;
    extest.enable = config.desktop.wayland.enable;
    gamescopeSession = {
      enable = true;
    };
  };
}
