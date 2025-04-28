# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./avizo.nix
    ./blueman-applet.nix
    ./cbatticon.nix
    ./dunst.nix
    ./nm-applet.nix
    ./picom.nix
    ./swappy.nix
    ./swaync.nix
    ./xidlehook.nix
    ./xss-lock.nix

    ./hypr
    ./waybar
  ];
}