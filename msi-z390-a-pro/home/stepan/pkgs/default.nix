# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, extrapkgs, ... }: {
  home.packages = with pkgs; [
    # Default:
    catppuccin-kvantum
    catppuccin-papirus-folders
    dconf
    firefox
    flameshot
    inkscape
    jetbrains.pycharm-community
    linphone
    mattermost-desktop
    nmap
    pavucontrol
    poetry
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
    telegram-desktop
    transmission-gtk
    vault
    virt-manager
    vlc
    vscode
    wezterm
    xdg-utils
    zoom-us
  ];
}
