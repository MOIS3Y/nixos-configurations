# █▄▄ █░░ █░█ █▀▀ █▀▄▀█ ▄▀█ █▄░█ ▀
# █▄█ █▄▄ █▄█ ██▄ █░▀░█ █▀█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, ... }: {
  services.blueman = {
    enable = (
      config.desktop.enable &&
      config.desktop.devices.bluetooth.enable &&
      !config.services.desktopManager.gnome.enable
    );

    # Workaround for a bug in nixpkgs: the default 'withApplet = true' generates
    # a systemd drop-in (overrides.conf) that defines an 'ExecStart' without
    # clearing the original one from the package's base unit. This results in
    # duplicate ExecStart definitions during systemd merge, causing it to fail.
    # Setting it to false relies entirely on the upstream unit file.
    withApplet = false;
  };
}
