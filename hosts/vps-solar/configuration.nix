# █▀ █▀█ █░░ ▄▀█ █▀█   █▄░█ █ ▀▄▀
# ▄█ █▄█ █▄▄ █▀█ █▀▄   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -
# NixOS configuration for the Solar VPS (Helsinki).

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
    enable = true;
    device = "/dev/sda";
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
      rsync
      tree
      unzip
      wget
    ];
  };
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "solar";
    useDHCP = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        53
        25 # SMTP (Server-to-server routing)
        465 # SMTPS (Implicit TLS submission)
        587 # SMTP (STARTTLS submission)
        143 # IMAP (STARTTLS)
        993 # IMAPS (Implicit TLS)
        2056
        2096
        9001
        45876
      ];
      allowedUDPPorts = [
        53
        500
        4500
        45876
      ];
      allowedTCPPortRanges = [
        {
          from = 49152;
          to = 65535;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 49152;
          to = 65535;
        }
      ];
    };
  };

  nix = {
    package = pkgs.nix;
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
    qemuGuest.enable = true;
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
        # ... TODO: add jails for new mail server
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
            "RESTIC_REPOSITORY_FILE=${config.sops.secrets."backups/restic-solar/repository".path}"
            "RESTIC_PASSWORD_FILE=${config.sops.secrets."backups/restic-solar/password".path}"
            "DSB_BACKUP_PATH=/services"
          ];
          ExecStart = "${pkgs.writeShellScript "dsb-backup" ''
            ${lib.getExe pkgs.extra.dsb} \
              -o sftp.args='-i ${
                config.sops.secrets."backups/restic-solar/sftp/private_key".path
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
            "RESTIC_REPOSITORY_FILE=${config.sops.secrets."backups/restic-solar/repository".path}"
            "RESTIC_PASSWORD_FILE=${config.sops.secrets."backups/restic-solar/password".path}"
            "DSB_BACKUP_PATH=/services"
          ];
          ExecStart = "${pkgs.writeShellScript "dsb-prune" ''
            ${lib.getExe pkgs.extra.dsb} \
              -o sftp.args='-i ${
                config.sops.secrets."backups/restic-solar/sftp/private_key".path
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
          OnCalendar = "03:00 Asia/Chita";
          Persistent = true;
        };
      };
      dsb-prune = {
        description = "Timer for Docker Services Backup Prune";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "Sat 04:00 Asia/Chita";
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
    defaultHostSopsFile = ../../secrets/hosts/vps-solar/secrets.yaml;
    secrets = {
      "backups/restic-solar/password" = { };
      "backups/restic-solar/repository" = { };
      "backups/restic-solar/sftp/private_key" = { };
    };
  };

  time.timeZone = "UTC";

  system.stateVersion = "26.05";
}
