# █░░ █▀█ █▀▀ █ █▄░█ █▀▄ ▀
# █▄▄ █▄█ █▄█ █ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.logind = {
    # add common logind attrs here ...
  }
  # optional:
  // lib.optionalAttrs config.desktop.devices.lid.enable {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };
}
