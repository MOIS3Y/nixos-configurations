# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./lf.nix
    ./mangohud.nix
    ./mellowplayer.nix
    ./vscode.nix
    ./wezterm.nix
  ];
}
