# █░░ ▄▀█ █▀█ ▀█▀ █▀█ █▀█ ▀
# █▄▄ █▀█ █▀▀ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: with lib; {
  services = mkIf config.desktop.laptop.enable {
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      lidSwitchDocked = "ignore";
    };
    tlp = {
      enable = true;
    };
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
    };
  };
}
