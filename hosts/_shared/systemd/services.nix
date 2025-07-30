# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ...}: let
  inherit (lib)
    optionalAttrs
    mkForce
    getExe;
  inherit (config.desktop)
    devices
    xorg;
in {
  systemd.user.services = {
    # add base systemd services here ...
  } // optionalAttrs (devices.touchpad.enable && xorg.enable) {
    touchegg-client = {
      description = "Touchégg. The client.";
      wantedBy = mkForce [];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${getExe pkgs.touchegg}";
      };
    };
  };
}
