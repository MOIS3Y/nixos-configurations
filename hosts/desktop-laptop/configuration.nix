# █░█ ▄▀█ █▀█ ▀█▀ █▀█ █▀█   █▄░█ █ ▀▄▀
# █▀█ █▀█ █▀▀ ░█░ █▄█ █▀▀   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -- -
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
      monitors = [
        {
          name = "eDP-1"; # primary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 0;
          y = 0;
          enabled = true;
        }
        {
          name = "HDMI-A-1"; # secondary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 1920; # connected to the right of eDP-1
          y = 0;
          enabled = true;
        }
      ];
      keyboard = {
        enable = true;
        settings = {
          name = "at-translated-set-2-keyboard";
          kb_layout = "us,ru";
          kb_model = "pc104";
          kb_options = "grp:alt_shift_toggle";
        };
      };
      touchpad = {
        enable = true;
      };
      battery.enable = true;
      lid.enable = true;
      bluetooth.enable = true;
    };
    cursor = { }; # ? Default arrts from module
  };

  system.stateVersion = "22.11";
}
