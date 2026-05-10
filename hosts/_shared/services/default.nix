# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./blueman.nix
    ./desktop-manager.nix
    ./display-manager.nix
    ./dleyna.nix
    ./fstrim.nix
    ./geoclue2.nix
    ./gnome.nix
    ./greetd.nix
    ./gvfs.nix
    ./lact.nix
    ./logind.nix
    ./openrgb.nix
    ./openssh.nix
    ./pipewire.nix
    ./printing.nix
    ./tlp.nix
    ./udev.nix
    ./upower.nix
    ./xray.nix
  ];
}
