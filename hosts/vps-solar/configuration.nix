# █▀ █▀█ █░░ ▄▀█ █▀█   █▄░█ █ ▀▄▀
# ▄█ █▄█ █▄▄ █▀█ █▀▄   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- -
# NixOS configuration for the Solar VPS (Netherlands).

{
  inputs,
  pkgs,
  ...
}:
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
  };
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "solar";
    useDHCP = false;
    interfaces.ens3 = {
      useDHCP = false;
      # Spoof/Hardcode the MAC address required by the hosting provider
      macAddress = "52:54:00:73:63:A6";
      ipv4.addresses = [
        {
          address = "132.243.115.92";
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
        53
        25 # SMTP (Server-to-server routing)
        465 # SMTPS (Implicit TLS submission)
        587 # SMTP (STARTTLS submission)
        143 # IMAP (STARTTLS)
        993 # IMAPS (Implicit TLS)
      ];
      allowedUDPPorts = [
        53
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
    qemuGuest.enable = true;
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

  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "26.05";
}
