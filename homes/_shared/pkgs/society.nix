# █▀ █▀█ █▀▀ █ █▀▀ ▀█▀ █▄█ ▀
# ▄█ █▄█ █▄▄ █ ██▄ ░█░ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    linphone
    mattermost-desktop
    telegram-desktop
    zoom-us
  ];
}
