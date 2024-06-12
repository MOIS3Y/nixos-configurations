# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager = {
      pantheon = {
        enable = false;
        extraWingpanelIndicators = [ pkgs.wingpanel-indicator-ayatana ];
        extraSwitchboardPlugs = [ pkgs.pantheon-tweaks ];
      };
    };
    windowManager = {
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
    };
    videoDrivers = [ "amdgpu" "intel" ];
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
