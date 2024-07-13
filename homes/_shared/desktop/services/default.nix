# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

# ! Note: 
# for the blueman applet to work, 'blueman' service should be enabled system-wide
# since it requires running 'blueman-mechanism' service activated.
# You can enable it in system configuration:
# services.blueman.enable = true;

# ? Declared by:
# https://github.com/nix-community/home-manager/blob/master/modules/services/blueman-applet.nix
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{config, pkgs, ...}: {
  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  # need to be fixed Error network-manager-applet.service:
  # !Failed to start network-manager-applet.service: Unit tray.target not found.
  # https://github.com/nix-community/home-manager/issues/2064

  # alternative:
  # used xsession.enable = true; in HM configuration
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
	};
}
