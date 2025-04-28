# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {

  imports = [
    # Custom modules:
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
  colorSchemeName = lib.mkForce "catppuccin_mocha";
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

  sops = {
    defaultHostSopsFile = ../../secrets/hosts/desktop-workstation/secrets.yaml;
    secrets = {};
  };

  networking.hostName = "workstation";

  time.timeZone = "Asia/Chita";

  # Set desktop configuration:
  desktop = {
    enable = true;
    xorg = {
      enable = false;
      windowManagers = [ "awesome" ];
    };
    wayland = {
      enable = true;
      compositors = [ "hyprland" ];
    };
    games = {
      enable = true;
      xpadneo.enable = true;
      externalStorage = {
        enable = true;
        storagePath = "/dev/disk/by-label/games";
        mountPath = "/home/stepan/Games";
      };
      extraPackages = [
        pkgs.bottles
        (pkgs.retroarch.withCores (cores: with cores; [
          nestopia
        ]))
      ];
    };
    devices = {
      monitors = [
        {
          name = "DP-1";  # primary
          width = 1920;
          height = 1080;
          refreshRate = 144;
          x = 0;
          y =0;
          enabled = true;
        }
        {
          name = "HDMI-A-1";  # secondary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 1920;  # connected to the right of DP-1
          y =0;
          enabled = true;      
        }
      ];
      keyboard = {
        enable = true;
        settings = {
          name = "logitech-k370s/k375s";
          kb_layout = "us,ru";
          kb_model = "pc104";
          kb_options = "grp:alt_shift_toggle";
        };
      };
      bluetooth.enable = true;
      ddcci.enable = true;
    };
    cursor = {}; # ? Default arrts from module 
    assets = {}; # ? Default arrts from module 
    apps = with config.desktop.utils; {
      terminal = kitty;
      spare-terminal = alacritty;
      browser = firefox;
      filemanager = nautilus;
      launcher = wofi;
      lockscreen = hyprlock;
      visual-text-editor = vscode;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}