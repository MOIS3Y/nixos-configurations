# █▀▀ █▀█ █▀▀ ▀
# █▄█ █▀▀ █▄█ ▄
# -- -- -- -- -
# Configures GNU Privacy Guard (GPG).

{ config, ... }:
{
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };
}
