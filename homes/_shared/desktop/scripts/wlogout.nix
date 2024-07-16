# █░█░█ █░░ █▀█ █▀▀ █▀█ █░█ ▀█▀ ▀
# ▀▄▀▄▀ █▄▄ █▄█ █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: with config.desktop.utils; with config.desktop.assets.sounds; {
  lock = "${sleep} 0.5; ${paplay} ${switch-beep} & ${hyprlock}";
  hibernate = "${sleep} 1; ${systemctl} hibernate";
  logout = "${sleep} 1; ${wayland-logout}";
  shutdown = "${sleep} 1; ${systemctl} poweroff";
  suspend = "${sleep} 1; ${systemctl} suspend";
  reboot = "${sleep} 1; ${systemctl} reboot";
}
