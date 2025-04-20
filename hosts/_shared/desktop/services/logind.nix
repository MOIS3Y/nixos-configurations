# █░░ █▀█ █▀▀ █ █▄░█ █▀▄ ▀
# █▄▄ █▄█ █▄█ █ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.logind = lib.mkIf config.desktop.laptop.enable {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
}