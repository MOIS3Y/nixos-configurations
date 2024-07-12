# █░░ ▄▀█ █▀█ ▀█▀ █▀█ █▀█ ▀
# █▄▄ █▀█ █▀▀ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.laptop;
in {
  options.desktop.laptop = with lib; {
    enable = mkEnableOption "Enable laptop services";
  };
  config = with pkgs; with lib; mkIf cfg.enable {
    services = {
      logind = {
        lidSwitch = "suspend";
        lidSwitchExternalPower = "suspend";
        lidSwitchDocked = "ignore";
      };
      tlp = {
        enable = true;
      };
      upower = {
        enable = false;
        percentageLow = 15;
        percentageCritical = 5;
      };
    };
  };
}
