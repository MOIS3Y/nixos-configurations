# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./coolercontrol.nix
    ./hyprland.nix
    ./nh.nix
    ./ssh.nix
    ./steam.nix
    ./wireshark.nix
    ./zsh.nix
  ];
}
