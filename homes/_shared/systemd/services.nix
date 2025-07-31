# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{config, pkgs, lib, osConfig, ... }: let 
  inherit (config.desktop)
    scripts;
in {
  systemd.user.services = {
    # add common systemd user services here ...
  }
  // lib.optionalAttrs config.services.picom.enable {
    # ? override systemd unit:
    picom = {
      Service.Restart = lib.mkForce "always";
      Service.RestartSec = lib.mkForce 90;
      Service.ExecCondition = lib.mkForce [
      "${lib.getExe pkgs.bash} -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
      ];
    };
  }
  // lib.optionalAttrs config.services.xidlehook.enable {
    # ? override systemd unit:
    xidlehook = {
      Service.Restart = lib.mkForce "always";
      Service.RestartSec = lib.mkForce 90;
      Service.ExecCondition = lib.mkForce [
        "${lib.getExe pkgs.bash} -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
      ];
    };
  }
  // lib.optionalAttrs(
      (osConfig.services.xserver.windowManager.qtile.enable ||
      osConfig.services.xserver.windowManager.awesome.enable) && 
      !osConfig.services.desktopManager.gnome.enable
    ) {
    # ? custom systemd unit:
    xss-lock = {
      Unit = {
        Description = "xss-lock, session locker service";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = "${scripts.xss-lock.lock}";
        ExecStartPre = "${scripts.xss-lock.dpms-off}";
        Restart = "always";
        RestartSec = 90;
        ExecCondition = lib.mkForce [
          "${lib.getExe pkgs.bash} -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
        ];
      };
    };
  };
}
