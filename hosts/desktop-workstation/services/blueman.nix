# █▄▄ █░░ █░█ █▀▀ █▀▄▀█ ▄▀█ █▄░█ ▀
# █▄█ █▄▄ █▄█ ██▄ █░▀░█ █▀█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  # ! required for blueman-applet HM-systemd-service (hide error msg)
  services.blueman.enable = true;
}
