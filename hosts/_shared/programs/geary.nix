# █▀▀ █▀▀ ▄▀█ █▀█ █▄█ ▀
# █▄█ ██▄ █▀█ █▀▄ ░█░ ▄
# -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  programs.geary = {
    enable = lib.mkDefault config.desktop.enable;
  };
}
