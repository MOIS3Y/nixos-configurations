# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./blueman.nix
    ./fstrim.nix
    ./openssh.nix
    ./strongswan.nix
    ./upower.nix
    ./xserver.nix
  ];
}
