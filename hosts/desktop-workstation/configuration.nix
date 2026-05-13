# █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█   █▄░█ █ ▀▄▀
# ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
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
        # Skipping tests while upstream sorts it out, revert once
        # Hydra consistently builds openldap green.
        # see: https://github.com/NixOS/nixpkgs/issues/513245
        (pkgs.bottles.override {
          # Intercept the buildFHSEnv function passed to the bottles wrapper
          buildFHSEnv =
            args:
            pkgs.buildFHSEnv (
              args
              // {
                multiPkgs =
                  envPkgs:
                  let
                    # Get the original list of packages
                    originalPkgs = args.multiPkgs envPkgs;

                    # Create our custom openldap without tests
                    customLdap = envPkgs.openldap.overrideAttrs (_: {
                      doCheck = false;
                    });
                  in
                  # Remove the broken openldap from the original list and add the custom one
                  builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
              }
            );
        })
        (pkgs.retroarch.withCores (cores: with cores; [ nestopia ]))
        pkgs.dualsensectl
      ];
    };
    devices = {
      monitors = [
        {
          name = "DP-1"; # primary
          width = 1920;
          height = 1080;
          refreshRate = 144;
          x = 0;
          y = 0;
          enabled = true;
        }
        {
          name = "HDMI-A-1"; # secondary
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 1920; # connected to the right of DP-1
          y = 0;
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
    };
    cursor = { }; # ? Default arrts from module
  };

  system.stateVersion = "22.11";
}
