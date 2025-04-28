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

{ config, lib, ... }: lib.mkIf config.desktop.devices.bluetooth.enable {
  services.blueman-applet.enable = true;
}