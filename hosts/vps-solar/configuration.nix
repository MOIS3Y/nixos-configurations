# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }: {
  imports = [
    ../../modules/colors

    ../_shared/console

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
      enable = false;
    };
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "admserv" ];
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

  programs.zsh.enable = true;
  
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = true;
    settings = {
      PermitRootLogin = "yes";  # TODO: disable after deploy
      PasswordAuthentication = true;  # TODO: disable after deploy
      LogLevel = "INFO";
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = { 
      admvps = {
        isNormalUser = true;
        description = "Stepan Zhukovsky";
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        packages = with pkgs; [];
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
