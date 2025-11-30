# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    # common:
    ./ssh
    ./direnv.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./htop.nix
    ./lf.nix
    ./lsd.nix
    ./nvchad.nix
    ./ruff.nix
    ./zsh.nix

    # desktop:
    ./alacritty.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./kitty.nix
    ./mangohud.nix
    ./mellowplayer.nix
    ./rofi.nix
    ./swappy.nix
    ./swaylock.nix
    ./vscode.nix
    ./wezterm.nix
    ./waybar.nix
    ./wayfire.nix
    ./wlogout.nix
    ./wofi.nix
    ./zed.nix
  ];
}
