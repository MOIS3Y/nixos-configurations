# █▄░█ █▀▀ ▀█▀ █░█░█ █▀█ █▀█ █▄▀ █ █▄░█ █▀▀ ▀
# █░▀█ ██▄ ░█░ ▀▄▀▄▀ █▄█ █▀▄ █░█ █ █░▀█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, lib, ...}: {

  # ? redefine hostName:
  networking.hostName = lib.mkForce "workstation";

  # ? Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  imports = [
    ../../_shared/networking
  ];
}
