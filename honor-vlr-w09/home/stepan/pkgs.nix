# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- 
{ config, pkgs, ... }: {
  home.packages = with pkgs; [   
    catppuccin-kvantum
    catppuccin-cursors                            
    firefox
    flameshot
    jetbrains.pycharm-community
    linphone
    mattermost-desktop
    poetry
    telegram-desktop
    virt-manager
    vlc
    vscode
    zoom-us
  ];
}
