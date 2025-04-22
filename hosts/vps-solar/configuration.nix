# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }: {
  imports = [
    # Custom modules:
    ../../modules/colors
    # Shared configuration:
    ../_shared/console
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix # virtual
  ];

  boot.loader.grub = {
    device = "/dev/vda";
    configurationLimit = 7;
  };

  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = with pkgs; [
      bottom
      curl
      dnsutils
      docker-compose
      nitch
      git
      htop
      jq
      extra.nvchad
      ncdu
      nitch
      rsync
      tree
      unzip
      wget
    ];
    etc = {
      # ? Mailu fail2ban filters and actions
      # TODO: move it in row conf files
      "fail2ban/filter.d/bad-auth-bots.conf".text = ''
        [Definition]
        failregex = ^\s?\S+ mailu\-front\[\d+\]: \S+ \S+ \[info\] \d+#\d+: \*\d+ client login failed: \"AUTH not supported\" while in http auth state, client: <HOST>, server:
        ignoreregex =
        journalmatch = CONTAINER_TAG=mailu-front
      '';
      "fail2ban/filter.d/bad-auth.conf".text = ''
        [Definition]
        failregex = : Authentication attempt from <HOST> has been rate-limited\.$
        ignoreregex =
        journalmatch = CONTAINER_TAG=mailu-admin
      '';
      "fail2ban/action.d/docker-action-net.conf".text = ''
        [Definition]
        actionstart = ipset --create f2b-bad-auth-bots nethash
            iptables -I DOCKER-USER -m set --match-set f2b-bad-auth-bots src -p tcp -m tcp --dport 25 -j DROP
        actionstop = iptables -D DOCKER-USER -m set --match-set f2b-bad-auth-bots src -p tcp -m tcp --dport 25 -j DROP
            ipset --destroy f2b-bad-auth-bots
        actionban = ipset add -exist f2b-bad-auth-bots <ip>/24
        actionunban = ipset del -exist f2b-bad-auth-bots <ip>/24
      '';
      "fail2ban/action.d/docker-action.conf".text = ''
        [Definition]
        actionstart = ipset --create f2b-bad-auth iphash
            iptables -I DOCKER-USER -m set --match-set f2b-bad-auth src -j DROP
        actionstop = iptables -D DOCKER-USER -m set --match-set f2b-bad-auth src -j DROP
            ipset --destroy f2b-bad-auth
        actionban = ipset add -exist f2b-bad-auth <ip>
        actionunban = ipset del -exist f2b-bad-auth <ip>
      '';
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "solar";
    interfaces = {
      ens3.ipv4.addresses = [{
        address = "89.110.68.134";
        prefixLength = 24;
      }];
    };
    defaultGateway = "89.110.68.1";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
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
    (final: prev:{
      extra = {
        nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
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
      extraPackages = [
        pkgs.ipset
      ];
      jails = {
        bad-auth-bots = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "bad-auth-bots";
            bantime = 604800;
            findtime = 600;
            maxretry = 5;
            action = "docker-action-net";
          };
        };
        bad-auth = {
          settings = {
            enabled = true;
            backend = "systemd";
            filter = "bad-auth";
            bantime = 604800;
            findtime = 900;
            maxretry = 15;
            action = "docker-action";
          };
        };
      };
    };
    openssh = {
      enable = true;
      startWhenNeeded = true;
      allowSFTP = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      listenAddresses = [
        {
          addr = "0.0.0.0";
          port = 2222;
        }
      ];
      banner = ''
        █▀ █▀█ █░░ ▄▀█ █▀█
        ▄█ █▄█ █▄▄ █▀█ █▀▄
      '';
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
        packages = [];
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
      containers =  {
        portainer-agent = {
          image = "portainer/agent:2.20.1-alpine";
          hostname = "portainer-agent";
          autoStart = true;
          ports = [
            "9001:9001"
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/var/lib/docker/volumes:/var/lib/docker/volumes"
          ];
          extraOptions = [
            "--privileged"
          ];
        };
      };
    };
  };

  time.timeZone = "Europe/Amsterdam";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}