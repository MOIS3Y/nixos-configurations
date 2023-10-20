# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [   
    catppuccin-kvantum
    catppuccin-papirus-folders
    dconf
    firefox
    flameshot
    gnome.dconf-editor
    inkscape
    jetbrains.pycharm-community
    linphone
    mattermost-desktop
    nmap
    pavucontrol
    poetry
    rofi
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
    telegram-desktop
    vault
    virt-manager
    vlc
    vscode
    wezterm
    xdg-utils
    zoom-us
  ];
}
