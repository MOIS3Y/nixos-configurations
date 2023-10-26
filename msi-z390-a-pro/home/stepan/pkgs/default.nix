# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, extrapkgs, ... }: {
  home.packages = with pkgs; [
    # Default:
    catppuccin-kvantum
    catppuccin-papirus-folders
    dconf
    dnsutils
    eww  # TODO: enable in programs after configure
    firefox
    flameshot
    helix
    inkscape
    jetbrains.pycharm-community
    linphone
    mattermost-desktop
    nmap
    pavucontrol
    poetry
    protonup-qt
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
    sqlitebrowser
    telegram-desktop
    transmission-gtk
    vault
    virt-manager
    vlc
    vscode
    xdg-utils
    zoom-us
    # Extra-pkgs:
    extrapkgs.i3lock-run
    extrapkgs.xidlehook-caffeine
  ];
}
