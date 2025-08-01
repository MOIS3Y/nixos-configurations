# █░░ █ █▄▄ █ █▄░█ █▀█ █░█ ▀█▀ ▀
# █▄▄ █ █▄█ █ █░▀█ █▀▀ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.libinput = {
    enable = config.desktop.xorg.enable;
    touchpad = lib.mkIf config.desktop.devices.touchpad.enable {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
}
