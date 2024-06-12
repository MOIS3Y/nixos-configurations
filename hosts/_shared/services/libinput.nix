# █░░ █ █▄▄ █ █▄░█ █▀█ █░█ ▀█▀ ▀
# █▄▄ █ █▄█ █ █░▀█ █▀▀ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;              # default true
      scrollMethod = "twofinger";  # default "twofinger"
      disableWhileTyping = true;   # default false
    };
  };
}
