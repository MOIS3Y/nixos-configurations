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
    amdgpu.overdrive.enable = lib.mkDefault false;
    bluetooth = {
      enable = lib.mkDefault true;
      powerOnBoot = true;
    };
    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };
    openrazer = {
      # ? needed for Razer Leviathan V2
      enable = lib.elem config.networking.hostName [ "workstation" ];
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
