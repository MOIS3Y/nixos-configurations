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
    (ranger.override { imagePreviewSupport = true; })
    rofi
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
    telegram-desktop
    ueberzug
    vault
    virt-manager
    vlc
    vscode
    w3m
    wezterm
    xdg-utils
    xdragon
    zoom-us
  ];
}
