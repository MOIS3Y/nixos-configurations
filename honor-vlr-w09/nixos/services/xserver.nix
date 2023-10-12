# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.pantheon = {
        enable = true;
        extraWingpanelIndicators = [ pkgs.wingpanel-indicator-ayatana ];
        extraSwitchboardPlugs = [ pkgs.pantheon-tweaks ];
      };
      windowManager = {
        awesome.enable = true;
        qtile.enable = true;
      };
      layout = "us";
      xkbVariant = "";
      # Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true; 
    };
  };
}
