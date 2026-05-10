# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./avizo.nix
    ./gpg-agent.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./nm-applet.nix
    ./swaync.nix
  ];
}
