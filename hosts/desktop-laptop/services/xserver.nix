# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: 
  let
    extra-pkgs = pkgs.callPackage ../extrapkgs {};
  in {
  services.xserver = {
    enable = true;
    displayManager = { 
      sddm = { 
        enable = true;
        autoNumlock = true;
        theme = "${extra-pkgs.sugar-candy}";
        settings = {
          Theme = { CursorTheme = "Catppuccin-Mocha-Blue-Cursors"; };
        };
      };
      lightdm = {
        enable = false;
      };
    };
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
    xkb = {
      variant = "";
      options = "grp:alt_shift_toggle";
      layout = "us,ru";
    };
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}
