# █▀ █▀█ █░░ ▄▀█ █▀█   █▄░█ █ ▀▄▀
# ▄█ █▄█ █▄▄ █▀█ █▀▄   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -
# NixOS configuration for the Solar VPS (Netherlands).

{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (builtins) readFile;
  raw = ../../raw/fail2ban;
  f2b = type: name: {
    name = "fail2ban/${type}.d/${name}.conf";
    value = {
      text = readFile "${raw}/${type}.d/${name}.conf";
    };
  };
in
{
  imports = [
    # Custom modules:
    ../../modules/appearance
    # Shared configuration:
    ../_shared/console.nix
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix # virtual
  ];

  boot.loader.grub = {
    device = "/dev/vda";
    configurationLimit = 7;
  };

  environment = {
    shells = [
      pkgs.bash
      pkgs.zsh
    ];
    systemPackages = with pkgs; [
      bottom
      curl
      dnsutils
      docker-compose
      nitch
      git
      htop
      ipset
      jq
      extra.nvchad
      ncdu
      nitch
      rsync
      tree
      unzip
      wget
    ];
    etc = lib.listToAttrs [
      # ? Mailu fail2ban filters and actions:
      (f2b "filter" "mailu-bad-auth-bots")
      (f2b "filter" "mailu-bad-auth")
      (f2b "action" "mailu-docker-action-net")
      (f2b "action" "mailu-docker-action")

      # ? Gitea fail2ban fielters and acttions:
      (f2b "filter" "gitea-bad-auth")
      (f2b "filter" "gitea-bots")
      (f2b "filter" "gitea-ssh")
      (f2b "action" "gitea-docker-action")
      (f2b "action" "gitea-docker-action-net")
    ];
  };
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "solar";
    interfaces = {
      ens3.ipv4.addresses = [
        {
          address = "89.110.68.134";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "89.110.68.1";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    firewall = {
      enable = true;
    };
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "admvps" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      extra = {
        nvchad = inputs.nix4nvchad.packages."${pkgs.stdenv.hostPlatform.system}".nvchad;
      };
    })
  ];

  programs = {
    nh = {
      enable = true;
      flake = "/home/admvps/.setup";
    };
    zsh = {
      enable = true;
    };
  };

  services = {
    fail2ban = {
      enable = true;
      extraPackages = [ pkgs.ipset ];
      jails = {
        mailu-bad-auth-bots = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "mailu-bad-auth-bots";
            journalmatch = "SYSLOG_IDENTIFIER=mailu-front";
            bantime = 604800;
            findtime = 600;
            maxretry = 5;
            action = "mailu-docker-action-net";
          };
        };
        mailu-bad-auth = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "mailu-bad-auth";
            journalmatch = "SYSLOG_IDENTIFIER=mailu-admin";
            bantime = 604800;
            findtime = 900;
            maxretry = 5;
            action = "mailu-docker-action";
          };
        };
        gitea-bad-auth = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "gitea-bad-auth";
            journalmatch = "SYSLOG_IDENTIFIER=gitea";
            bantime = 3600;
            findtime = 600;
            maxretry = 5;
            action = "gitea-docker-action";
          };
        };
        gitea-bots = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "gitea-bots";
            journalmatch = "SYSLOG_IDENTIFIER=gitea";
            bantime = 86400;
            findtime = 3600;
            maxretry = 5;
            action = "gitea-docker-action-net";
          };
        };
        gitea-ssh = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "gitea-ssh";
            journalmatch = "SYSLOG_IDENTIFIER=gitea";
            bantime = 7200;
            findtime = 3600;
            maxretry = 10;
            action = "gitea-docker-action";
          };
        };
        sshd = {
          settings = {
            enable = true;
            port = "22,2222";
          };
        };
      };
    };
    openssh = {
      enable = true;
      allowSFTP = true;
      ports = [ 2222 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        LogLevel = "VERBOSE";
      };

    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      admvps = {
        isNormalUser = true;
        description = "Stepan Zhukovsky";
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        packages = [ ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2uRkkbZ7Z9Zc0WHIZCBRBU8EylvBHoR7lB6sldtJp8 stepan@zhukovsky.me"
        ];
      };
      # ... add more users here
    };
  };

  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers = {
        portainer-agent = {
          image = "portainer/agent:2.33.5-alpine";
          hostname = "portainer-agent";
          autoStart = true;
          ports = [ "9001:9001" ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/var/lib/docker/volumes:/var/lib/docker/volumes"
          ];
          extraOptions = [ "--privileged" ];
        };
      };
    };
  };

  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "23.11";
}
