# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./blueman.nix
    ./display-manager.nix
    ./greetd.nix
    ./libinput.nix
    ./logind.nix
    ./openssh.nix
    ./pipewire.nix
    ./printing.nix
    ./tlp.nix
    ./touchegg.nix
    ./upower.nix
    ./xserver.nix
  ];
}
