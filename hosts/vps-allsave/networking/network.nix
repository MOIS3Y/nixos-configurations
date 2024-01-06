# █▄░█ █▀▀ ▀█▀ █░█░█ █▀█ █▀█ █▄▀ ▀
# █░▀█ ██▄ ░█░ ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      appendNameservers = [ "8.8.8.8" ];
    };
    hostName = "allsave";
  };
}
