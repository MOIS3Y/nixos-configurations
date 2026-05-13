# █▀ █░█ ▄▀█ █▀█ █▀▀ █▀▄ ▀
# ▄█ █▀█ █▀█ █▀▄ ██▄ █▄▀ ▄
# -- -- -- -- -- -- -- --
# Main entry point for shared home-manager configurations.

{ ... }:
{
  imports = [
    ./config
    ./pkgs
    ./programs
    ./services
    ./sops
    ./systemd
  ];
}
