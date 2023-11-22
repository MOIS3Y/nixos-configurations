# ▀█▀ █▀█ ▄▀█ █▄█ ▄▄ ▀█▀ ▄▀█ █▀█ █▀▀ █▀▀ ▀█▀ ▀
# ░█░ █▀▄ █▀█ ░█░ ░░ ░█░ █▀█ █▀▄ █▄█ ██▄ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

# Description:
# -- -- -- --
# need to be fixed Error network-manager-applet.service:
# !Failed to start network-manager-applet.service: Unit tray.target not found.
# https://github.com/nix-community/home-manager/issues/2064

# alternative:
# used xsession.enable = true; in HM configuration

{ config, pkgs, ...}: {
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
	};
}
