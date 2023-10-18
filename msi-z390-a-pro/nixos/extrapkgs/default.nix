# █▀▀ ▀▄▀ ▀█▀ █▀█ ▄▀█ █▀█ █▄▀ █▀▀ █▀ ▀
# ██▄ █░█ ░█░ █▀▄ █▀█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  sugar-candy = pkgs.callPackage ./sugar-candy.nix {};
}
