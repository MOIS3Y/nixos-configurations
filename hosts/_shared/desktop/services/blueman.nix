# █▄▄ █░░ █░█ █▀▀ █▀▄▀█ ▄▀█ █▄░█ ▀
# █▄█ █▄▄ █▄█ ██▄ █░▀░█ █▀█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: lib.mkIf config.desktop.devices.bluetooth.enable {
  # ! required for blueman-applet HM-systemd-service (hide error msg)
  services.blueman.enable = true;
}