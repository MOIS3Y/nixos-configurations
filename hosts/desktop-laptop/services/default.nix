# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./fstrim.nix
    ./logind.nix
    ./openssh.nix
    ./strongswan.nix
    ./tlp.nix
    ./touchegg.nix
    ./xserver.nix
  ];
}
