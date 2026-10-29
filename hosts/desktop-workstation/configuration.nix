# █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█   █▄░█ █ ▀▄▀
# ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the primary workstation.

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Custom modules:
    ../../modules/appearance
    ../../modules/desktop
    ../../modules/host
    # Shared configuration:
    ../_shared
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix # MSI B850 GAMING PRO WIFI6E
  ];

  # Override _shared configuration:
  host = {
    boot = {
      grubTheme = "msi";
    };
    hardware = {
      gpu.enable = true;
      graphics.enable = true;
      bluetooth.enable = true;
      ddcci.enable = true;
      openRGB.enable = false;
      coolercontrol.enable = true;
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
    secrets = {
      "coolercontrol/username" = {
        owner = config.users.users.stepan.name;
        inherit (config.users.users.stepan) group;
      };
      "coolercontrol/password" = {
        owner = config.users.users.stepan.name;
        inherit (config.users.users.stepan) group;
      };
      "xray/workstation" = {
        path = "/etc/xray/config.json";
        mode = "0644";
      };
    };
  };

  networking.hostName = "workstation";

  time.timeZone = "Asia/Chita";

  boot = {
    loader = {
      efi.canTouchEfiVariables = lib.mkForce false;
      grub.efiInstallAsRemovable = true;
    };
    extraModulePackages = [
      config.boot.kernelPackages.nct6687d
      config.boot.kernelPackages.ddcci-driver
    ];
    kernelModules = [
      "k10temp"
      "nct6687"
      "i2c-piix4"
      "ddcci_backlight"
      "i2c-dev"
    ];
    extraModprobeConfig = ''
      options nct6687 msi_fan_brute_force=1
    '';
  };

  # Set desktop configuration:
  desktop = {
    enable = true;
    displayManager = {
      enable = true;
      greetd.enable = true;
    };
    compositors = [ "niri" ];
    games = {
      enable = true;
      xpadneo.enable = true;
      externalStorage = {
        enable = true;
        storagePath = "/dev/disk/by-label/games";
        mountPath = "/home/stepan/Games";
      };
      extraPackages = [
        pkgs.protonup-qt
        pkgs.bottles
        (pkgs.retroarch.withCores (cores: with cores; [ nestopia ]))
        pkgs.dualsensectl
      ];
    };
    devices = {
      monitors = {
        "DP-1" = {
          mode = "1920x1080@165.003";
          variable-refresh-rate = {
            enable = true;
            on-demand = true;
          };
          position = {
            x = 0;
            y = 0;
          };
          focus-at-startup = true;
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60.000";
          position = {
            x = 1920;
            y = 0;
          };
        };
      };
    };
  };

  system.stateVersion = "22.11";
}
