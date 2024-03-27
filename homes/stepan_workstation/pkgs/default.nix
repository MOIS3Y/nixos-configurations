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
    gettext
    gimp
    gnumake
    inkscape
    imv
    jetbrains.pycharm-community
    lapce
    linphone
    lua
    lm_sensors
    mattermost-desktop
    nmap
    pavucontrol
    poetry
    protonup-qt
    pulseaudio
    ripgrep
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
    sassc
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
    wireplumber
    xdg-utils
    xwaylandvideobridge
    zoom-us
    # Extra-pkgs:
    extrapkgs.i3lock-run
    extrapkgs.xidlehook-caffeine
  ];
}
