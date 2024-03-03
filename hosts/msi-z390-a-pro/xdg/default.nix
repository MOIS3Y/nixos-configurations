# ▀▄▀ █▀▄ █▀▀ ▀
# █░█ █▄▀ █▄█ ▄
# -- -- -- -- -

{ config, pkgs, ... }: {
  xdg.portal = {
    enable = true;
    config = {
      common.default = "*";
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };
}
