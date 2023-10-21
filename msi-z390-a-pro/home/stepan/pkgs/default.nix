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
    gnome.dconf-editor
    inkscape
    jetbrains.pycharm-community
    linphone
    lutris
    # (lutris.override { extraPkgs = pkgs: with extrapkgs; [ wine-ge ]; })
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
    # Extra:
    extrapkgs.wine-ge
  ];
}
