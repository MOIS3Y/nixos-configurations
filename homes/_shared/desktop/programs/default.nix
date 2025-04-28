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
    ./rofi.nix
    ./swaylock.nix
    ./vscode.nix
    ./wezterm.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
