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
    ./niri.nix
    ./ssh.nix
    ./steam.nix
    ./wayfire.nix
    ./wireshark.nix
    ./zsh.nix
  ];
}
