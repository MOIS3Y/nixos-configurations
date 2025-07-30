# █░░ ▄▀█ █▀▀ ▀█▀ ▀
# █▄▄ █▀█ █▄▄ ░█░ ▄
# -- -- -- -- -- --

{ config, ... }: {
  services.lact = {
    enable = config.host.hardware.gpu.enable;
  };
}
