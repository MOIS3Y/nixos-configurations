# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, utils, ... }: {
  # common:
  khal = pkgs.callPackage ./khal.nix { inherit config utils; };
  lf = pkgs.callPackage ./lf.nix { inherit config utils; };
  ssh = pkgs.callPackage ./ssh.nix { inherit config utils; };
  # wayland:
  hypridle = pkgs.callPackage ./hypridle.nix { inherit utils; };
  hyprland = pkgs.callPackage ./hyprland.nix { inherit utils; };
  waybar = pkgs.callPackage ./waybar.nix { inherit config utils; };
  wlogout = pkgs.callPackage ./wlogout.nix { inherit utils; };
  # xorg:
  dunst = pkgs.callPackage ./dunst.nix { inherit utils; };
  xidlehook = pkgs.callPackage ./xidlehook.nix { inherit config utils; };
  xss-lock = pkgs.callPackage ./xss-lock.nix { inherit config utils; };
}
