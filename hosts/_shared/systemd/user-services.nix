# █░█ █▀ █▀▀ █▀█   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ...}: let
  inherit (lib)
    optionalAttrs
    mkForce
    getExe;
  inherit (config.desktop)
    devices
    xorg;
  inherit (config.services)
    desktopManager;
in {
  systemd.user.services = {
    # add base systemd user services here ...
  } 
  // optionalAttrs (devices.touchpad.enable && xorg.enable) {
    touchegg-client = {
      description = "Touchégg. The client.";
      wantedBy = mkForce [];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${getExe pkgs.touchegg}";
      };
    };
  }
  // optionalAttrs (config.desktop.enable && !desktopManager.gnome.enable) {
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
        '';
      };
    };
    evolution-alarm-notify = {
      description = "evolution-alarm-notify daemon for get alarm reminders";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = with pkgs; ''
          ${evolution-data-server}/libexec/evolution-data-server/evolution-alarm-notify
        '';
      };
    };
  };
}
