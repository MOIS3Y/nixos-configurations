# ▄▀█ █░░ █░░ █▀ ▄▀█ █░█ █▀▀   █▄░█ █ ▀▄▀
# █▀█ █▄▄ █▄▄ ▄█ █▀█ ▀▄▀ ██▄   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the local home server.

{
  config,
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
    ../_shared/fonts.nix
    ../_shared/nix.nix
    ../_shared/nixpkgs.nix
    ../_shared/sops.nix
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix
  ];

  # Override _shared configuration:
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        devices = [ "nodev" ];
        efiSupport = true;
        configurationLimit = 7;
        gfxmodeEfi = "1920x1080";
      };
    };
    swraid = {
      enable = true;
      mdadmConf = ''
        ARRAY /dev/md1 level=raid1 num-devices=2 metadata=1.2 name=allsave:1 UUID=1408f414:46bd022f:a3be13b0:c1560046
        ARRAY /dev/md2 level=raid1 num-devices=2 metadata=1.2 name=allsave:2 UUID=4db185fa:54cf0828:89ed0f44:1b63382a
        MAILADDR stepan@zhukovsky.me
        MAILFROM allsave@zhukovsky.me
      '';
    };
    extraModprobeConfig = ''
      options kvm_amd nested=1
    '';
    kernel.sysctl = {
      "net.bridge.bridge-nf-call-ip6tables" = 0;
      "net.bridge.bridge-nf-call-iptables" = 0;
      "net.bridge.bridge-nf-call-arptables" = 0;
    };
    kernelModules = [ "br_netfilter" ];
  };

  networking = {
    hostName = "allsave";
    useDHCP = false; # DHCP is enabled in the configuration of each interface
    bridges = {
      vmbr0.interfaces = [ "enp5s0" ];
    };
    interfaces = {
      vmbr0.useDHCP = true;
      enp7s0.useDHCP = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # OpenSSH
        80 # HTTP reverse proxy
        443 # HTTPS reverse proxy
        445 # SMB file sharing
        631 # CUPS printing
        2022 # SFTPGo SFTP service
        2222 # Gitea SSH
        8096 # Jellyfin web interface
        8200 # MiniDLNA web interface
        32400 # Plex Media Server
        51413 # BitTorrent peer traffic
      ];
      allowedUDPPorts = [
        1900 # MiniDLNA and Plex SSDP discovery
        1901 # Plex DLNA discovery
        5353 # Avahi and Plex mDNS discovery
        7359 # Jellyfin discovery
        32410 # Plex GDM discovery
        32412 # Plex GDM discovery
        32413 # Plex GDM discovery
        32414 # Plex GDM discovery
        51413 # BitTorrent peer traffic
      ];
    };
  };

  nix.settings.trusted-users = lib.mkForce [ "admserv" ];

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
      git
      htop
      jq
      lm_sensors
      ncdu
      fastfetch
      nitch
      ntfs3g
      parted
      rsync
      ripgrep
      tree
      wget
      unzip
    ];
    etc = lib.listToAttrs [
      # ? Gitea fail2ban filters and actions:
      (f2b "filter" "gitea-bad-auth")
      (f2b "filter" "gitea-bots")
      (f2b "filter" "gitea-ssh")
      (f2b "action" "gitea-docker-action")
      (f2b "action" "gitea-docker-action-net")
    ];
  };

  services = {
    fstrim = {
      enable = true;
    };
    openssh = {
      enable = true;
      startWhenNeeded = true;
      allowSFTP = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        LogLevel = "INFO";
      };
      listenAddresses = [
        {
          addr = "0.0.0.0";
          port = 22; # default
        }
      ];

    };
    printing = {
      enable = true;
      startWhenNeeded = true;
      webInterface = true; # default value
      defaultShared = true;
      listenAddresses = [ "*:631" ]; # all
      allowFrom = [ "all" ];
      drivers = [ pkgs.pantum-driver ];
      clientConf = ''
        ServerName print.zhukovsky.me
      '';
      extraConf = ''
        ServerAlias *
      '';
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    fail2ban = {
      enable = true;
      extraPackages = [ pkgs.ipset ];
      jails = {
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
  };

  programs = {
    nh = {
      enable = true;
      flake = "/home/admserv/.setup";
    };
    ssh = {
      startAgent = true;
    };
    zsh = {
      enable = true;
    };
    msmtp = {
      enable = true;
      accounts = {
        default = {
          auth = true;
          tls = true;
          tls_starttls = false;
          from = "allsave@zhukovsky.me";
          host = "smtp.zhukovsky.me";
          port = 465;
          user = "allsave@zhukovsky.me";
          passwordeval = "cat ${config.sops.secrets."passwords/msmtp".path}";
        };
      };
    };
  };

  users.users = {
    admserv = {
      isNormalUser = true;
      description = "Stepan Zhukovsky";
      extraGroups = [
        "wheel"
        "libvirtd"
      ];
      shell = pkgs.zsh;
      packages = [ ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIN8ntFxD/6St6f8I9U+W+uqw9tQZQk6nxSBkaYpB5QN home server"
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  sops = {
    defaultHostSopsFile = ../../secrets/hosts/server-allsave/secrets.yaml;
    secrets = {
      "passwords/msmtp" = {
        owner = config.users.users.admserv.name;
        inherit (config.users.users.admserv) group;
      };
      # add more secrets here ...
    };
  };

  time.timeZone = "Asia/Chita";

  system.stateVersion = "22.11";
}
