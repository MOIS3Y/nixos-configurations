# █▀▀ █ █░░ █▀▀ ▄▄ █▀█ █▀█ █░░ █░░ █▀▀ █▀█ ▀
# █▀░ █ █▄▄ ██▄ ░░ █▀▄ █▄█ █▄▄ █▄▄ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  programs.file-roller = {
    enable = lib.mkDefault config.desktop.enable;
  };
}
