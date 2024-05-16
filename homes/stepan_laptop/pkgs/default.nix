# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Default:
    arandr
    catppuccin-kvantum
    catppuccin-papirus-folders
    dconf
    dnsutils
    docker-compose
    eww  # TODO: enable in programs after configure
    firefox
    flameshot
    gettext
    gnumake
    inkscape
    imv
    linphone
    lua
    lm_sensors
    mattermost-desktop
    nmap
    pavucontrol
    poetry
    pulseaudio
    ripgrep
    rofi-bluetooth
    rofi-power-menu
    sassc
    sqlitebrowser
    telegram-desktop
    transmission-gtk
    vault 
    virt-manager
    vlc
    vscode
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
