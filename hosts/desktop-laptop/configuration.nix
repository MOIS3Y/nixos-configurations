# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {

  imports = [
    ../../modules/colors
    ./hardware-configuration.nix  # honor-vlr-w09
    ./boot
    ./console
    ./environment
    ./fonts
    ./gnome
    ./hardware
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./programs
    ./security
    ./services
    ./sound
    ./sops
    ./systemd
    ./users
    ./virtualisation
    ./xdg
  ];

  # Set colorScheme
  colorSchemeName = "catppuccin_mocha";

  # Set your time zone.
  time.timeZone = "Asia/Chita";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
