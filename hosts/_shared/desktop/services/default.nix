# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ ... }: {
  imports = [
    ./display-manager.nix
    ./blueman.nix
    ./logind.nix
    ./pipewire.nix
    ./tlp.nix
    ./upower.nix
  ];
}