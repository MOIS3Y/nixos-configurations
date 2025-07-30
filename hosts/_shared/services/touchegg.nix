# ▀█▀ █▀█ █░█ █▀▀ █░█ █▀▀ █▀▀ █▀▀ ▀
# ░█░ █▄█ █▄█ █▄▄ █▀█ ██▄ █▄█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- 

{ config, ... }: let
  inherit (config.desktop)
    devices
    xorg;
in {
  services.touchegg = {
    enable = (xorg.enable or false) && (devices.touchpad.enable or false);
  };
}
