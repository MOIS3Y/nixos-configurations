# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.xorg;
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
  services.xserver = lib.mkIf cfg.enable {
    enable = true;
    windowManager = lib.attrsets.getAttrs cfg.windowManagers windowManagers;
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
  # ? needed for awesomeWM sound scripts (pactl)
  environment.systemPackages = if cfg.enable then [ pkgs.pulseaudio ] else []; 
}