# ▀▄▀ ▀▄▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ █░█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, extrapkgs, ... }:
  let
    locker = extrapkgs.i3lock-run;
  in {
  programs.xss-lock = {
    enable = true;
    lockerCommand = "${locker}/bin/i3lock-run -s catppuccin_mocha -f Inter";
  };
}
