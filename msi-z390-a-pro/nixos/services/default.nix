# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./fstrim.nix
    ./openssh.nix
    ./strongswan.nix
    ./upower.nix
    ./xserver.nix
  ];
}
