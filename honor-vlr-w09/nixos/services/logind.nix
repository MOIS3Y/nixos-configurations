# █░░ █▀█ █▀▀ █ █▄░█ █▀▄ ▀
# █▄▄ █▄█ █▄█ █ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
}
