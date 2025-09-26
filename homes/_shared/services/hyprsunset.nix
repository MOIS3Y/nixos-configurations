# █░█ █▄█ █▀█ █▀█ █▀ █░█ █▄░█ █▀ █▀▀ ▀█▀ ▀
# █▀█ ░█░ █▀▀ █▀▄ ▄█ █▄█ █░▀█ ▄█ ██▄ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: {
  services.hyprsunset = {
    enable = lib.mkDefault config.wayland.windowManager.hyprland.enable;
    settings = {
      max-gamma = 150;
      profile = [
        {
          time = "7:30";
          identity = true;  # disable filter between 7:30-21:59
        }
        {
          time = "22:00";
          temperature = 5000;  # enable filter between 22:00-7:29
        }
      ];
    };
  };
}
