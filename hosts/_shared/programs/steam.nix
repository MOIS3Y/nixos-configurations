# █▀ ▀█▀ █▀▀ ▄▀█ █▀▄▀█ ▀
# ▄█ ░█░ ██▄ █▀█ █░▀░█ ▄
# -- -- -- -- -- -- -- -

{ config, ... }: {
  programs.steam = {
    enable = config.desktop.games.enable;
    extest.enable = config.desktop.enable;
    gamescopeSession = {
      enable = true;
    };
  };
}
