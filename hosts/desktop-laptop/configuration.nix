# █░░ ▄▀█ █▀█ ▀█▀ █▀█ █▀█   █▄░█ █ ▀▄▀ ▀
# █▄▄ █▀█ █▀▀ ░█░ █▄█ █▀▀   █░▀█ █ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the Lenovo ThinkBook 14 G7 ARP.

{
  inputs,
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
    defaultHostSopsFile = ../../secrets/hosts/desktop-laptop/secrets.yaml;
    secrets = {
      "xray/laptop" = {
        path = "/etc/xray/config.json";
        mode = "0644";
      };
    };
  };

  boot = {
    loader = {
      grub = {
        theme = inputs.distro-grub-themes.packages.${system}.lenovo-grub-theme;
      };
    };
  };

  services = {
    fprintd.enable = true;
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
          mode = "1920x1200@60.003";
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
      lid.enable = true;
    };
  };

  system.stateVersion = "22.11";
}
