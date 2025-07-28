# █░░ █ █▄▄ █ █▄░█ █▀█ █░█ ▀█▀ ▀
# █▄▄ █ █▄█ █ █░▀█ █▀▀ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.libinput = lib.mkIf config.desktop.xorg.enable {
    enable = true;
    touchpad = lib.mkIf config.desktop.devices.touchpad.enable {
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
}