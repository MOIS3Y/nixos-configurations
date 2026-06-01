# █░█ ▄▀█ █▀█ █▀▄ █░█░█ ▄▀█ █▀█ █▀▀ ▀
# █▀█ █▀█ █▀▄ █▄▀ ▀▄▀▄▀ █▀█ █▀▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- --
# Configures core hardware features like GPU, Bluetooth, and peripherals.

{
  config,
  lib,
  ...
}:
{
  hardware = {
    amdgpu.overdrive.enable = config.host.hardware.gpu.enable;
    bluetooth = {
      enable = config.host.hardware.bluetooth.enable;
      powerOnBoot = true;
    };
    graphics = lib.mkIf config.host.hardware.graphics.enable {
      enable = true;
      enable32Bit = true;
    };
    openrazer = {
      # ? needed for Razer Leviathan V2
      # ? waiting: https://github.com/openrazer/openrazer/pull/2644
      # enable = lib.elem config.networking.hostName [ "workstation" ];

      # ! build failure: https://github.com/NixOS/nixpkgs/issues/414604
      enable = false;
      users = [ "stepan" ];
    };
    xone = {
      #? fix last firmware update Xbox One Wireless Controller (bluetooth rumble)
      enable = config.desktop.games.xpadneo.enable;
    };
    xpadneo = {
      enable = config.desktop.games.xpadneo.enable;
    };
  };
}
