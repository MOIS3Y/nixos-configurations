# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./avizo.nix
    ./blueman-applet.nix
    ./cbatticon.nix
    ./dunst.nix
    ./gpg-agent.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./nm-applet.nix
    ./picom.nix
    ./swaync.nix
    ./swayosd.nix
    ./xidlehook.nix
  ];
}
