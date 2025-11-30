# █░░ █▀█ █▀▀ █ █▄░█ █▀▄ ▀
# █▄▄ █▄█ █▄█ █ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  services.logind.settings.Login = {
    # add common logind attrs here ...
  }
  # optional:
  // lib.optionalAttrs config.desktop.devices.lid.enable {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
