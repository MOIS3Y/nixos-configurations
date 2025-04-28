# █░░ █▀█ █▀▀ █ █▄░█ █▀▄ ▀
# █▄▄ █▄█ █▄█ █ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.logind = lib.mkIf config.desktop.devices.lid.enable {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
}