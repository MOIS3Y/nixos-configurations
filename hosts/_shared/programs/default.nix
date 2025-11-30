# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    ./coolercontrol.nix
    ./dconf.nix
    ./geary.nix
    ./hyprland.nix
    ./nh.nix
    ./niri.nix
    ./nix-ld.nix
    ./ssh.nix
    ./steam.nix
    ./wayfire.nix
    ./wireshark.nix
    ./zsh.nix
  ];
}
