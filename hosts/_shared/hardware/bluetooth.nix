# █▄▄ █░░ █░█ █▀▀ ▀█▀ █▀█ █▀█ ▀█▀ █░█ ▀
# █▄█ █▄▄ █▄█ ██▄ ░█░ █▄█ █▄█ ░█░ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, ... }: {
  hardware.bluetooth = {
    enable = config.host.hardware.bluetooth.enable;
    powerOnBoot = true;
  };
}
