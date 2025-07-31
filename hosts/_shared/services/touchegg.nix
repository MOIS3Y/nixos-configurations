# ▀█▀ █▀█ █░█ █▀▀ █░█ █▀▀ █▀▀ █▀▀ ▀
# ░█░ █▄█ █▄█ █▄▄ █▀█ ██▄ █▄█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- 

{ config, ... }: let
  inherit (config.desktop)
    devices
    xorg;
in {
  services.touchegg = {
    enable = (xorg.enable && devices.touchpad.enable);
  };
}
