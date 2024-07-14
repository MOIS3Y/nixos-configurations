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
  ];
}
