# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./blueman.nix
    ./display-manager.nix
    ./fstrim.nix
    ./greetd.nix
    ./lact.nix
    ./libinput.nix
    ./logind.nix
    ./openrgb.nix
    ./openssh.nix
    ./pipewire.nix
    ./printing.nix
    ./tlp.nix
    ./touchegg.nix
    ./udev.nix
    ./upower.nix
    ./xserver.nix
  ];
}
