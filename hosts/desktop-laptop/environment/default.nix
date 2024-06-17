# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/environment/variables.nix
    ../../_shared/environment/shells.nix
    ../../_shared/environment/pathsToLink.nix
    ../../_shared/environment/systemPackages/common.nix
    ../../_shared/environment/systemPackages/desktop.nix
    ../../_shared/environment/systemPackages/lua.nix
    ../../_shared/environment/systemPackages/managment.nix
    ../../_shared/environment/systemPackages/monitoring.nix
    ../../_shared/environment/systemPackages/network.nix
    ../../_shared/environment/systemPackages/python.nix
    ../../_shared/environment/systemPackages/security.nix
  ];
}
