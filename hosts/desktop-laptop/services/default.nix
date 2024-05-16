# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./blueman.nix
    ./fstrim.nix
    ./logind.nix
    ./openssh.nix
    ./strongswan.nix
    ./tlp.nix
    # ./touchegg.nix
    ./xserver.nix
  ];
}
