# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Default:
    arandr
    amdgpu_top
    catppuccin-kvantum
    catppuccin-papirus-folders
    dconf
    dnsutils
    docker-compose
    eww  # TODO: enable in programs after configure
    firefox
    flameshot
    gimp
    inkscape
    jetbrains.pycharm-community
    linphone
    lua
    lm_sensors
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
    vrrtest
    wine
    winetricks
    wireguard-tools
    xdg-utils
    zoom-us
    # Extra-pkgs:
    extrapkgs.i3lock-run
    extrapkgs.xidlehook-caffeine
  ];
}
