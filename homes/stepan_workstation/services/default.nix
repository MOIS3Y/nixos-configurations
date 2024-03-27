# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ./blueman-applet.nix
    # ./cbatticon.nix
    ./dunst.nix
    ./nm-applet.nix
    ./picom.nix
    ./xidlehook.nix
  ];
}
