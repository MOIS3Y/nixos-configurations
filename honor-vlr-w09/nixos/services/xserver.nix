# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: 
  let
    extrapkgs = pkgs.callPackage ../extrapkgs {};
  in {
  services.xserver = {
    enable = true;
    displayManager = { 
      sddm = { 
        enable = false;
        theme = "${extrapkgs.sugar-candy}";
      };
      lightdm = {
        enable = true;
      };
    };
    desktopManager.pantheon = {
        enable = true;
        extraWingpanelIndicators = [ pkgs.wingpanel-indicator-ayatana ];
        extraSwitchboardPlugs = [ pkgs.pantheon-tweaks ];
    };
    windowManager = {
      awesome.enable = true;
      qtile = { 
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          psutil
          requests
        ];
      };
    };
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle";
    xkbVariant = "";
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}
