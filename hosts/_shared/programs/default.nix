# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./hyprland.nix
    ./nh.nix
    ./ssh.nix
    ./wireshark.nix
    ./zsh.nix
  ];
}
