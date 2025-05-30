# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./avizo.nix
    ./blueman-applet.nix
    ./cbatticon.nix
    ./dunst.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./nm-applet.nix
    ./picom.nix
    ./swappy.nix
    ./swaync.nix
    ./xidlehook.nix
    ./xss-lock.nix
  ];
}