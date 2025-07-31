# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.desktop;
  windowManagers = {
    awesome = {
      enable = true;
      luaModules = [
        pkgs.lua52Packages.lgi
      ];
    };
    qtile = { 
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        psutil
        requests
      ];
    };
    # add more X11 window managers here ...
  };
  in {
  services.xserver = {
    enable = cfg.xorg.enable;
    windowManager = lib.optionalAttrs cfg.xorg.enable (
      lib.attrsets.getAttrs cfg.windowManagers windowManagers
    );
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
