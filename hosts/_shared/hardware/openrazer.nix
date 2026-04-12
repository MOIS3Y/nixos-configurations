# █▀█ █▀█ █▀▀ █▄░█ █▀█ ▄▀█ ▀█ █▀▀ █▀█ ▀
# █▄█ █▀▀ ██▄ █░▀█ █▀▄ █▀█ █▄ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

# ? needed for Razer Leviathan V2
# ? waiting: https://github.com/openrazer/openrazer/pull/2644

{ config, lib, ... }: {
  hardware.openrazer = {
    enable = lib.elem config.networking.hostName [ "workstation" ];
    users = [ "stepan" ];
  };
}
