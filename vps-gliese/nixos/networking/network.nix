# █▄░█ █▀▀ ▀█▀ █░█░█ █▀█ █▀█ █▄▀ ▀
# █░▀█ ██▄ ░█░ ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  networking = {
    interfaces = {
      ens3.ipv4.addresses = [{
        address = "91.201.113.181";
        prefixLength = 24;
      }];
    };
    defaultGateway = "91.201.113.1";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
    hostName = "gliese";
  };
}
