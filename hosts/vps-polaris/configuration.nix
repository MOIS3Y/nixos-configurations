# █▀█ █▀█ █░░ ▄▀█ █▀█ █ █▀   █▄░█ █ ▀▄▀ ▀
# █▀▀ █▄█ █▄▄ █▀█ █▀▄ █ ▄█   █░▀█ █ █░█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- --
# NixOS configuration for the Polaris VPS (Netherlands).

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
    ./hardware-configuration.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/vda";
      configurationLimit = 7;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    shells = [
      pkgs.bash
      pkgs.zsh
    ];
    systemPackages = with pkgs; [
      curl
      dnsutils
      docker-compose
      git
      htop
      extra.nvchad
    ];
  };

  networking = {
    hostName = "polaris";
    useDHCP = false;
    interfaces = {
      ens3.ipv4.addresses = [
        {
          address = "46.151.31.83";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "46.151.31.1";
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
    settings.trusted-users = [ "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      extra = {
        nvchad = inputs.nix4nvchad.packages."${pkgs.stdenv.hostPlatform.system}".default;
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
    qemuGuest.enable = true;
    fail2ban = {
      enable = true;
      extraPackages = [ pkgs.ipset ];
      jails.sshd = {
        settings = {
          enable = true;
          port = "22";
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
  };

  virtualisation.docker.enable = true;

  users.users.admvps = {
    isNormalUser = true;
    description = "Stepan Zhukovsky";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWcSa4ppznvaWpGK5jfkyF2Y1CEN1GbQvr50XdB24FW polaris.zhukovsky.me"
    ];
  };

  time.timeZone = "UTC";

  system.stateVersion = "26.05";
}
