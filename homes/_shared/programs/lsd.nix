# █░░ █▀ █▀▄ ▀
# █▄▄ ▄█ █▄▀ ▄
# -- -- -- --
# Configures the lsd (Next gen ls command) program.

{ lib, ... }:
{
  programs.lsd = {
    enable = lib.mkDefault true;
  };
}
