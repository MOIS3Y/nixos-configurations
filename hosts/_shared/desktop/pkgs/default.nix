# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    appimage-run
    firefox
    libnotify
    pavucontrol
    xdg-utils
    config.desktop.cursor.package  # ! required for sddm cursor theme
  ];
}
