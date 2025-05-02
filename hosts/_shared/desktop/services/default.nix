# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./display-manager.nix
    ./blueman.nix
    ./greetd.nix
    ./libinput.nix
    ./logind.nix
    ./pipewire.nix
    ./tlp.nix
    ./touchegg.nix
    ./upower.nix
    ./xserver.nix
  ];
}