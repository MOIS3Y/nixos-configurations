# █▀█ ▄▀█ █▀▄▀█ ▀
# █▀▀ █▀█ █░▀░█ ▄
# -- -- -- -- -- 

{ config, pkgs, ... }: {
  security.pam.services.swaylock = {};  # ! require for swaylock
  security.pam.services.hyprlock = {};  # ! require for hyprlock
}
