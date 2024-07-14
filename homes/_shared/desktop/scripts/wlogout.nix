# █░█░█ █░░ █▀█ █▀▀ █▀█ █░█ ▀█▀ ▀
# ▀▄▀▄▀ █▄▄ █▄█ █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: with config.desktop.utils; {
  lock = "${sleep} 0.5; ${hyprlock}";
  hibernate = "${sleep} 1; ${systemctl} hibernate";
  logout = "${sleep} 1; ${wayland-logout}";
  shutdown = "${sleep} 1; ${systemctl} poweroff";
  suspend = "${sleep} 1; ${systemctl} suspend";
  reboot = "${sleep} 1; ${systemctl} reboot";
}
