# █▀▀ █▀▀ █▀█ █▀▀ █░░ █░█ █▀▀ ▀█ ▀
# █▄█ ██▄ █▄█ █▄▄ █▄▄ █▄█ ██▄ █▄ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: {
  services.geoclue2 = {
    enable = lib.mkDefault config.desktop.enable;
    enableDemoAgent = lib.mkDefault false; # ? GNOME has its own geoclue agent
  };
}
