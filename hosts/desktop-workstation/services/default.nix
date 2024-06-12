# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/services/blueman.nix
    ../../_shared/services/displayManager.nix
    ../../_shared/services/fstrim.nix
    ../../_shared/services/openssh.nix
    ../../_shared/services/strongswan.nix
    ../../_shared/services/xserver.nix
  ];
}
