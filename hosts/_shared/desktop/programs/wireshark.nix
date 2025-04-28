# █░█░█ █ █▀█ █▀▀ █▀ █░█ ▄▀█ █▀█ █▄▀ ▀
# ▀▄▀▄▀ █ █▀▄ ██▄ ▄█ █▀█ █▀█ █▀▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- 

{ pkgs, ...}: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;  # ? gui version
  };
}