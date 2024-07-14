# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: with pkgs; {
  # common:
  khal = callPackage ./khal.nix { inherit config; };
  lf = callPackage ./lf.nix { inherit config; };
  # wayland:
  hypridle = callPackage ./hypridle.nix { inherit config; };
  hyprland = callPackage ./hyprland.nix { inherit config; };
  waybar = callPackage ./waybar.nix { inherit config; };
  wlogout = callPackage ./wlogout.nix { inherit config; };
  # xorg:
  dunst = callPackage ./dunst.nix { inherit config; };
  xidlehook = callPackage ./xidlehook.nix { inherit config; };
  xss-lock = callPackage ./xss-lock.nix { inherit config; };
}
