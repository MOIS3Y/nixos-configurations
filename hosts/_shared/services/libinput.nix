# █░░ █ █▄▄ █ █▄░█ █▀█ █░█ ▀█▀ ▀
# █▄▄ █ █▄█ █ █░▀█ █▀▀ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.libinput = {
    enable = lib.mkDefault config.desktop.xorg.enable;
    touchpad = lib.mkIf config.desktop.devices.touchpad.enable {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
}
