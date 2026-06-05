# █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█   █▄░█ █ ▀▄▀
# ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the primary workstation.

{
  config,
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
    ./hardware-configuration.nix # msi-z390-a-pro
  ];

  # Override _shared configuration:
  host = {
    boot = {
      grubTheme = "msi";
    };
    hardware = {
      motherboard.cpu = "intel";
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
          mode = "1920x1080@143.855";
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
