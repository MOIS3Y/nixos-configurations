# █▀▀ █▀█ █▀▀ ▄▄ ▄▀█ █▀▀ █▀▀ █▄░█ ▀█▀ ▀
# █▄█ █▀▀ █▄█ ░░ █▀█ █▄█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-tty;
      program = "pinentry";
    };
  };
}