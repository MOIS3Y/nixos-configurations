# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    adw-gtk3
    appimage-run
    catppuccin-cursors.mochaBlue
    firefox
    gparted
    imv
    libnotify
    pavucontrol
    xdg-utils
  ];
}
