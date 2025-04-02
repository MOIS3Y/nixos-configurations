# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports = [
    # Custom modules:
    ../../modules/assets
    ../../modules/colors
    ../../modules/desktop
    # Shared configuration:
    ../_shared/boot
    ../_shared/console
    ../_shared/desktop
    ../_shared/environment
    ../_shared/fonts
    ../_shared/hardware
    ../_shared/i18n
    ../_shared/networking
    ../_shared/nix
    ../_shared/nixpkgs
    ../_shared/programs
    ../_shared/security
    ../_shared/services
    ../_shared/sops
    ../_shared/users
    ../_shared/virtualisation
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix  # msi-z390-a-pro
  ];
  # Override _shared configuration:
  host = {
    boot = {
      grubTheme = "msi";
    };
    hardware = {
      motherboard = "intel";
      cpu = "intel";
      gpu = true;
      updateMicrocode = true;
      ddcci = true;
      openRGB = false;
      coolercontrol = true;
    };
    virtualisation = {
      docker = {
        enable = true;
        startWhenNeeded = true;
      };
      libvirtd = {
        enable = true;
        startWhenNeeded = true;
      };
    };
    users = [ "stepan" ];
    flake = "/home/stepan/.setup";
  };

  desktop = {
    preset = "workstation";
    games = {
      enable = true;
      xpadneo.enable = true;
      externalStorage = {
        enable = true;
      };
      extraPackages = [
        pkgs.bottles
      ];
    };
  };

  sops = {
    defaultHostSopsFile = ../../secrets/hosts/desktop-workstation/secrets.yaml;
    secrets = {};
  };

  networking.hostName = lib.mkForce "workstation";

  time.timeZone = "Asia/Chita";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
