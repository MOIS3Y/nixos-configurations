# █▄▀ █░█ ▄▀█ █░░ ▀
# █░█ █▀█ █▀█ █▄▄ ▄
# ! broken build https://github.com/NixOS/nixpkgs/issues/263504 waiting...
# -- -- -- -- -- --

{ config, pkgs, ... }: {
  programs.khal = {
    enable = true;
  };
}
