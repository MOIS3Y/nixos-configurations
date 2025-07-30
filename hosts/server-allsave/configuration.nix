# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports = [
    # Custom modules:
    ../../modules/colors
    # Shared configuration:
    ../_shared/console
    ../_shared/fonts
    ../_shared/nix
    ../_shared/nixpkgs
    ../_shared/sops
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
      enable = false;
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
      neofetch
      nitch
      ntfs3g
      parted
      rsync
      ripgrep
      tree
      wget
      unzip
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
          port = 22;  # default
        }
      ];
      banner = ''
        ▄▀█ █░░ █░░ █▀ ▄▀█ █░█ █▀▀
        █▀█ █▄▄ █▄▄ ▄█ █▀█ ▀▄▀ ██▄
      '';
    };
    printing = {
      enable = true;
      startWhenNeeded = true;
      webInterface = true;  # default value
      defaultShared = true;
      listenAddresses = [ "*:631" ];  # all
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
          host = "mail.zhukovsky.me";
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
      packages = [];
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
