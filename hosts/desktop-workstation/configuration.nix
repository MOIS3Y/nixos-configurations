# █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█   █▄░█ █ ▀▄▀
# ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the primary workstation.

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    # Custom modules:
    ../../modules/appearance
    ../../modules/desktop
    # Shared configuration:
    ../_shared
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix
  ];

  # override shared configuration:
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

  boot = {
    loader = {
      grub = {
        theme = inputs.distro-grub-themes.packages.${system}.msi-grub-theme;
        efiInstallAsRemovable = true;
      };
      efi.canTouchEfiVariables = lib.mkForce false;
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

  hardware = {
    amdgpu.overdrive.enable = true;
  };

  services = {
    udev.packages = [ pkgs.ddcutil ];
  };

  networking.hostName = "workstation";

  time.timeZone = "Asia/Chita";

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
