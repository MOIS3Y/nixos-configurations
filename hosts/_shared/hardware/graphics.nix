# █▀▀ █▀█ ▄▀█ █▀█ █░█ █ █▀▀ █▀ ▀
# █▄█ █▀▄ █▀█ █▀▀ █▀█ █ █▄▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{config, lib, ... }: {
  hardware.graphics = lib.mkIf config.host.hardware.graphics.enable {
    enable = true;
    enable32Bit = true;
  };
}