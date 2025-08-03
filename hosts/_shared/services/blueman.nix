# █▄▄ █░░ █░█ █▀▀ █▀▄▀█ ▄▀█ █▄░█ ▀
# █▄█ █▄▄ █▄█ ██▄ █░▀░█ █▀█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, ... }: {
  # ! required for blueman-applet HM-systemd-service (hide error msg)
  services.blueman.enable = (
    config.desktop.enable &&
    config.desktop.devices.bluetooth.enable &&
    !config.services.desktopManager.gnome.enable
  );
}
