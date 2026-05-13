# █▀▀ █▀█ █▀▀ ▄▄ ▄▀█ █▀▀ █▀▀ █▄░█ ▀█▀ ▀
# █▄█ █▀ █▀▀ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -
# Configures the GPG agent service with a TTY pinentry.

{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-tty;
      program = "pinentry";
    };
  };
}
