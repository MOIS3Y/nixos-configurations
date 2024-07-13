# ▀▄▀ █▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ ▄█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.xorg.enable {
  systemd.user.services.xss-lock = {
    Unit = {
      Description = "xss-lock, session locker service";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = with config.apps.scripts.xss-lock; {
      ExecStart = "${lock}";
      ExecStartPre = "${dpms-off}";
      Restart = "always";
      RestartSec = 90;
      ExecCondition = lib.mkForce [
        "${lib.getExe pkgs.bash} -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
      ];
    };
  };
}
