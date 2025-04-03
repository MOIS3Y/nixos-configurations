# █░█░█ █░░ █▀█ █▀▀ █▀█ █░█ ▀█▀ ▀
# ▀▄▀▄▀ █▄▄ █▄█ █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ config, ... }: let
  inherit (config.desktop.utils)
    hyprlock
    paplay
    sleep
    systemctl
    wayland-logout;
  inherit (config.desktop.assets.sounds)
    switch-beep; 
  in {
  desktop.scripts.wlogout = {
    lock = "${sleep} 0.5; ${paplay} ${switch-beep} & ${hyprlock}";
    hibernate = "${sleep} 1; ${systemctl} hibernate";
    logout = "${sleep} 1; ${wayland-logout}";
    shutdown = "${sleep} 1; ${systemctl} poweroff";
    suspend = "${sleep} 1; ${systemctl} suspend";
    reboot = "${sleep} 1; ${systemctl} reboot";
  };
}
