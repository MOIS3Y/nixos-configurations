# ▀▄▀ █ █▀▄ █░░ █▀▀ █░█ █▀█ █▀█ █▄▀ ▀
# █░█ █ █▄▀ █▄▄ ██▄ █▀█ █▄█ █▄█ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: 
  let
    notify = with pkgs; ''
      ${dunst}/bin/dunstify \
        "Power" "Computer will suspend very soon because of inactivity" \
        -u normal
      '';
    locker = with pkgs; ''
        ${extrapkgs.i3lock-run}/bin/i3lock-run \
        -s ${config.colorScheme.name} \
        -f Ubuntu
      '';
    suspend = "${pkgs.systemd}/bin/systemctl suspend";
  in {
  services.xidlehook = {
    enable = true;
    detect-sleep = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    environment = {
      PRIMARY_DISPLAY = "$(xrandr | awk '/ primary/{print $1}')";
    };
    timers = [
      {
        delay = 600;
        command = "${notify}";
      }
      {
        delay = 10;
        command = "${locker}";
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
    "${pkgs.bash}/bin/bash -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
  ];
}
