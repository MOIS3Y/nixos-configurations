# █▀ █░█ ▄▀█ █▀█ █▀▀ █▀▄ ▀
# ▄█ █▀█ █▀█ █▀▄ ██▄ █▄▀ ▄
# -- -- -- -- -- -- -- --
# Main entry point for shared host configurations.

{ ... }:

{
  imports = [
    ./boot.nix
    ./console.nix
    ./environment.nix
    ./fonts.nix
    ./hardware.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sops.nix
    ./systemd.nix
    ./users.nix
    ./virtualisation.nix
  ];
}
