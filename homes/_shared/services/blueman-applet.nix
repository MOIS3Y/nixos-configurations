# █▄▄ █░░ █░█ █▀▀ █▀▄▀█ ▄▀█ █▄░█ ▄▄ ▄▀█ █▀█ █▀█ █░░ █▀▀ ▀█▀ ▀
# █▄█ █▄▄ █▄█ ██▄ █░▀░█ █▀█ █░▀█ ░░ █▀█ █▀▀ █▀▀ █▄▄ ██▄ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

# ! Note: 
# for the blueman applet to work, 'blueman' service should be enabled system-wide
# since it requires running 'blueman-mechanism' service activated.
# You can enable it in system configuration:
# services.blueman.enable = true;
# ? Declared by:
# https://github.com/nix-community/home-manager/blob/master/modules/services/blueman-applet.nix

{ config, osConfig, ... }: {
  services.blueman-applet.enable = (
    config.desktop.enable &&
    config.desktop.devices.bluetooth.enable &&
    !osConfig.services.desktopManager.gnome.enable
  );
}
