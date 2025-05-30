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
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}