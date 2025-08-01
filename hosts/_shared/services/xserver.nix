# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
  in {
  services.xserver = {
    enable = cfg.xorg.enable;
    windowManager = {
      awesome = {
        enable = (
          lib.lists.elem "awesome" cfg.xorg.windowManagers &&
          !config.services.desktopManager.gnome.enable
        );
        luaModules = [
          pkgs.lua52Packages.lgi
        ];
      };
      qtile = { 
        enable = (
          lib.lists.elem "qtile" cfg.xorg.windowManagers &&
          !config.services.desktopManager.gnome.enable
        );
        extraPackages = python3Packages: [
          python3Packages.psutil
          python3Packages.requests
        ];
      };
    };
    xkb = {
      variant = "";
      options = "grp:alt_shift_toggle";
      layout = "us,ru";
    };
    deviceSection = ''
      Option "DRI" "3"
      Option "VariableRefresh" "true"
    '';
    exportConfiguration = true;
  };
}
