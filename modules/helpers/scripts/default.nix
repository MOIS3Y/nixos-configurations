# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: let
  utils = pkgs.callPackage ../utils { };
in {
  hypridle = pkgs.callPackage ./hypridle.nix { inherit utils; };
  khal = pkgs.callPackage ./khal.nix { inherit config utils; };
  lf = pkgs.callPackage ./lf.nix { inherit config utils; };
  ssh = pkgs.callPackage ./ssh.nix { inherit config utils; };
  wlogout = pkgs.callPackage ./wlogout.nix { inherit utils; };
}
