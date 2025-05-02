# ▀█▀ █▀█ █░█ █▀▀ █░█ █▀▀ █▀▀ █▀▀ ▀
# ░█░ █▄█ █▄█ █▄▄ █▀█ ██▄ █▄█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.xorg.enable {
  services.touchegg = lib.mkIf config.desktop.devices.touchpad.enable {
    enable = true;
  };
  # TODO: move it to systemd module then check if desktop.devices.touchpad.enable = true;
  systemd.user.services = lib.mkIf config.desktop.devices.touchpad.enable {
    touchegg-client = {
      description = "Touchégg. The client.";
      wantedBy = pkgs.lib.mkForce [];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.touchegg}";
      };
    };
  };
}