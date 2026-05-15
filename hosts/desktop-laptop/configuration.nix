# █░░ ▄▀█ █▀█ ▀█▀ █▀█ █▀█   █▄░█ █ ▀▄▀ ▀
# █▄▄ █▀█ █▀▀ ░█░ █▄█ █▀▀   █░▀█ █ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the Huawei Honor MagicBook (laptop).

{ pkgs, ... }:
{
  imports = [
    # Custom modules:
    ../../modules/appearance
    ../../modules/desktop
    ../../modules/host
    # Shared configuration:
    ../_shared
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix # honor-vlr-w09
  ];

  # Override _shared configuration:
  host = {
    boot = {
      grubTheme = "huawei";
    };
    hardware = {
      motherboard.cpu = "intel";
      graphics.enable = true;
      bluetooth.enable = true;
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
    defaultHostSopsFile = ../../secrets/hosts/desktop-laptop/secrets.yaml;
    secrets = {
      "xray/laptop" = {
        path = "/etc/xray/config.json";
        mode = "0644";
      };
    };
  };

  networking.hostName = "laptop";

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
      extraPackages = [
        pkgs.protonup-qt
        (pkgs.retroarch.withCores (cores: with cores; [ nestopia ]))
      ];
    };
    devices = {
      monitors = {
        "eDP-1" = {
          mode = "1920x1080@60.000";
          position = { x = 0; y = 0; };
          focus-at-startup = true;
        };
        "HDMI-A-1" = {
          mode = "1920x1080@60.000";
          position = { x = 1920; y = 0; };
        };
      };
      lid.enable = true;
    };
  };

  system.stateVersion = "22.11";
}
