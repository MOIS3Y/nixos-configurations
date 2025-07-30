# ▄▀█ █▀▄▀█ █▀▄ █▀▀ █▀█ █░█ ▀
# █▀█ █░▀░█ █▄▀ █▄█ █▀▀ █▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, ... }: {
  hardware.amdgpu = {
    overdrive.enable = config.host.hardware.gpu.enable;
  };
}
