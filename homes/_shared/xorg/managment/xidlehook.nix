# ▀▄▀ █ █▀▄ █░░ █▀▀ █░█ █▀█ █▀█ █▄▀ ▀
# █░█ █ █▄▀ █▄▄ ██▄ █▀█ █▄█ █▄█ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  services.xidlehook = with config.apps.scripts.xidlehook; {
    enable = true;
    detect-sleep = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    environment = {
      PRIMARY_DISPLAY = "$(${primary-display})";
    };
    timers = [
      {
        delay = 600;
        command = "${notify}";
      }
      {
        delay = 10;
        command = "${lock}";
      }
      {
        delay = 60;
        command = "${suspend}";
      }
    ];
  };
  # override systemd unit:
  systemd.user.services.xidlehook.Service.Restart = lib.mkForce "always";
  systemd.user.services.xidlehook.Service.RestartSec = lib.mkForce 90;
  systemd.user.services.xidlehook.Service.ExecCondition = lib.mkForce [
    "${lib.getExe pkgs.bash} -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
  ];
}
