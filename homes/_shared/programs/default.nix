# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./ssh

    ./direnv.nix
    ./git.nix
    ./helix.nix
    ./htop.nix
    ./lf.nix
    ./lsd.nix
    ./nvchad.nix
    ./ruff.nix
    ./zsh.nix
  ];
}
