# █▀ █▀█ █▀▀ █ █▀▀ ▀█▀ █▄█ ▀
# ▄█ █▄█ █▄▄ █ ██▄ ░█░ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{ pkgs, ... }: {
  home.packages = with pkgs; [
    mattermost-desktop
    telegram-desktop
    zoom-us
  ];
}
