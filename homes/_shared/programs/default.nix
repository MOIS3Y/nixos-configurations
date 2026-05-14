# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -
# Aggregates all home-manager program configurations.

{ ... }:
{
  imports = [
    # common:
    ./ssh.nix
    ./bat.nix
    ./direnv.nix
    ./gemini-cli.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./lsd.nix
    ./nvchad.nix
    ./ruff.nix
    ./yazi.nix
    ./zsh.nix

    # desktop:
    ./alacritty.nix
    ./dms.nix
    ./kitty.nix
    ./mangohud.nix
    ./niri.nix
    ./swappy.nix
    ./vscode.nix
    ./zed.nix
  ];
}
