# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./coolercontrol.nix
    ./dconf.nix
    ./file-roller.nix
    ./geary.nix
    ./hyprland.nix
    ./nh.nix
    ./ssh.nix
    ./steam.nix
    ./wireshark.nix
    ./zsh.nix
  ];
}
