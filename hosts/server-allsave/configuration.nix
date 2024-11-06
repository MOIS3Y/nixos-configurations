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
    ../../modules/grub
    # Shared configuration:
    ../_shared/console
    ../_shared/environment
    ../_shared/fonts
    ../_shared/hardware
    ../_shared/nix
    ../_shared/nixpkgs
    ../_shared/programs
    ../_shared/users
    ../_shared/virtualisation
    # Host autogenerate hardware configuration:
    ./hardware-configuration.nix
  ];
  # Override _shared configuration:
  host = {
    boot = {
      grubTheme = "gigabyte";
    };
    hardware = {
      cpu = "amd";
      updateMicrocode = true;
      bluetooth = false;
      graphics = false;
    };
    virtualisation = {
      docker = {
        enable = true;
      };
      libvirtd = {
        enable = false;  # TODO: enable after configure storage
      };
    };
    users = [ "admserv" ];
    flake = "/home/admserv/.setup";
  };

  boot = {
    loader.grub = {
      device = "/dev/disk/by-id/ata-HP_SSD_S650_120GB_HASA12100101184";
      configurationLimit = 7;
    };
    swraid = {
      enable = true;
      mdadmConf = ''
        ARRAY /dev/md0 level=raid1 num-devices=2 metadata=0.90 UUID=8bb2622a:203030e8:ac926b66:e55a92b1
        ARRAY /dev/md1 level=raid1 num-devices=2 metadata=1.2 name=allsave:1 UUID=1408f414:46bd022f:a3be13b0:c1560046
        ARRAY /dev/md2 level=raid1 num-devices=2 metadata=1.2 name=allsave:2 UUID=4db185fa:54cf0828:89ed0f44:1b63382a
        ARRAY /dev/md3 level=raid1 num-devices=2 metadata=1.2 name=allsave:3 UUID=14c9d6da:2e618286:df380868:d8d07f27
      '';
    };
  };

  networking = {
    hostName = "allsave";
    networkmanager = {
      enable = true;
      appendNameservers = [ "8.8.8.8" ];
    };
    firewall = { 
      enable = false;
    };
  };

  nix.settings.trusted-users = lib.mkForce [ "admserv" ];

  services = { 
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

  users.users.admserv.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIN8ntFxD/6St6f8I9U+W+uqw9tQZQk6nxSBkaYpB5QN home server"
  ];

  # Legacy host configuration engine path:
  # TODO: move it default path /var/lib/docker
  virtualisation.docker.daemon.settings = {
    data-root = "/services/docker/engine";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Asia/Chita";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
