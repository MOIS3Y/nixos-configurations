# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/colors

    ../_shared/console
    ../_shared/environment
    ../_shared/nix
    ../_shared/nixpkgs
    ../_shared/programs
    ../_shared/time
    ../_shared/users
    ../_shared/virtualisation

    ./hardware-configuration.nix # virtual
  ];

  host = {
    virtualisation = {
      docker = {
        enable = true;
        oci-containers = [ "portainer-agent" ];
      };
    };
    users = [ "admserv" ];
  };

  boot.loader.grub = {
    device = "/dev/vda";
    configurationLimit = 7;
  };

  environment.systemPackages = with pkgs; lib.mkForce [
    bottom
    curl
    dnsutils
    docker-compose
    nitch
    git
    htop
    jq
    neovim
    ncdu
    nitch
    rsync
    tree
    unzip
    wget
  ];

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

  nix.settings.trusted-users = lib.mkForce [ "admserv" ];
  nixpkgs.overlays = lib.mkForce [];

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

  users.users.admserv.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM2uRkkbZ7Z9Zc0WHIZCBRBU8EylvBHoR7lB6sldtJp8 stepan@zhukovsky.me"
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = lib.mkForce "Europe/Amsterdam";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
