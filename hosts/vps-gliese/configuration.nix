# █▀▀ █░░ █ █▀▀ █▀ █▀▀   █▄░█ █ ▀▄▀
# █▄█ █▄▄ █ ██▄ ▄█ ██▄   █░▀█ █ █░█
# -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the Gliese VPS (Netherlands).

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
      extra.dsb
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
    hostName = "gliese";
    useDHCP = false;
    interfaces.ens3 = {
      useDHCP = false;
      # Spoof/Hardcode the MAC address required by the hosting provider
      macAddress = "52:54:00:73:F9:DD";
      ipv4.addresses = [
        {
          address = "157.22.182.183";
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
      ];
      allowedUDPPorts = [
        53
        500
        4500
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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtpBAY/JGXUQ8tGhgxvPoffWcK9jNY/B/YmasmN6Ykv gliese.zhukovsky.me"
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
