# █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ ▀
# █▄▄ █▄█ █░▀█ █▀░ █ █▄█ ▄
# -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/config/dconf.nix
    ../../_shared/config/gtk.nix
    ../../_shared/config/pointer-cursor.nix
    ../../_shared/config/qt.nix
    ../../_shared/config/xdg.nix
  ];
}
