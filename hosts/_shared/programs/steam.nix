# █▀ ▀█▀ █▀▀ ▄▀█ █▀▄▀█ ▀
# ▄█ ░█░ ██▄ █▀█ █░▀░█ ▄
# -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  };
}
