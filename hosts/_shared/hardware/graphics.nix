# █▀▀ █▀█ ▄▀█ █▀█ █░█ █ █▀▀ █▀ ▀
# █▄█ █▀▄ █▀█ █▀▀ █▀█ █ █▄▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
