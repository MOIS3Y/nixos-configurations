# █▀█ █▀█ █▀█ ▀▄▀ █ █▀▄▀█ ▄▀█   █▄░█ █ ▀▄▀ ▀
# █▀▀ █▀▄ █▄█ █░█ █ █░▀░█ █▀█   █░▀█ █ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the Proxima VPS (Russia).

{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Custom modules:
    ../../modules/appearance
    # Shared configuration:
    ../_shared/console.nix
    ../_shared/sops.nix
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
      extra.dsb
      extra.xraymgr
      ncdu
      nitch
      restic
      rsync
      tree
      unzip
      wget
    ];
  };
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "proxima";
    useDHCP = false;
    interfaces.ens3 = {
      useDHCP = false;
      # Spoof/Hardcode the MAC address required by the hosting provider
      macAddress = "52:54:00:11:2C:B1";
      ipv4.addresses = [
        {
          address = "157.22.187.246";
          prefixLength = 32;
        }
      ];
    };
    # Explicitly specify the interface for the gateway
    # since it's outside the /32 subnet
    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        3478
        4443
        5223
        53
      ];
      allowedUDPPorts = [
        53
        3478
      ];
      allowedUDPPortRanges = [
        {
          from = 49152;
          to = 49200;
        }
      ];
    };
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "@wheel" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      extra = {
        nvchad = inputs.nix4nvchad.packages."${pkgs.stdenv.hostPlatform.system}".nvchad;
        dsb = inputs.dsb.packages."${pkgs.stdenv.hostPlatform.system}".default;
        xraymgr = inputs.xraymgr.packages."${pkgs.stdenv.hostPlatform.system}".default;
      };
    })
  ];

  programs = {
    nh = {
      enable = true;
      flake = "/home/admvps/.setup";
    };
    ssh.knownHosts = {
      "[83.234.160.93]:2022".publicKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDFc6AioPmPhYocNQkjs1KLUUcf0sXApd40PhZdxByh6";
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
        sshd = {
          settings = {
            enable = true;
            port = "22";
          };
        };
      };
    };
    openssh = {
      enable = true;
      allowSFTP = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        LogLevel = "VERBOSE";
      };
    };
    qemuGuest.enable = true;
  };

  systemd = {
    services = {
      dsb-backup = {
        description = "Docker Services Backup";
        after = [
          "network.target"
          "docker.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Environment = [
            "RESTIC_REPOSITORY_FILE=${config.sops.secrets."backups/restic-proxima/repository".path}"
            "RESTIC_PASSWORD_FILE=${config.sops.secrets."backups/restic-proxima/password".path}"
            "DSB_BACKUP_PATH=/services"
          ];
          ExecStart = "${pkgs.writeShellScript "dsb-backup" ''
            ${lib.getExe pkgs.extra.dsb} \
              -o sftp.args='-i ${
                config.sops.secrets."backups/restic-proxima/sftp/private_key".path
              } -o BatchMode=yes' \
              backup
          ''}";
        };
      };
      dsb-prune = {
        description = "Docker Services Backup Prune";
        after = [ "network.target" ];
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Environment = [
            "RESTIC_REPOSITORY_FILE=${config.sops.secrets."backups/restic-proxima/repository".path}"
            "RESTIC_PASSWORD_FILE=${config.sops.secrets."backups/restic-proxima/password".path}"
            "DSB_BACKUP_PATH=/services"
          ];
          ExecStart = "${pkgs.writeShellScript "dsb-prune" ''
            ${lib.getExe pkgs.extra.dsb} \
              -o sftp.args='-i ${
                config.sops.secrets."backups/restic-proxima/sftp/private_key".path
              } -o BatchMode=yes' \
              prune
          ''}";
        };
      };
    };
    timers = {
      dsb-backup = {
        description = "Timer for Docker Services Backup";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "22:00"; # Shifted for user's 04:00 AM GMT+9
          Persistent = true;
        };
      };
      dsb-prune = {
        description = "Timer for Docker Services Backup Prune";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "Sat 23:00"; # Shifted for user's 05:00 AM GMT+9
          Persistent = true;
        };
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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG6U1y4O0AdQ2EHhgBbQYtghcBzsHNRQx214+0JBHo/U proxima.zhukovsky.me"
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
          image = "portainer/agent:2.39.3-alpine";
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

  sops = {
    defaultHostSopsFile = ../../secrets/hosts/vps-proxima/secrets.yaml;
    secrets = {
      "backups/restic-proxima/password" = { };
      "backups/restic-proxima/repository" = { };
      "backups/restic-proxima/sftp/private_key" = { };
    };
  };

  time.timeZone = "Europe/Moscow";

  system.stateVersion = "26.05";
}
