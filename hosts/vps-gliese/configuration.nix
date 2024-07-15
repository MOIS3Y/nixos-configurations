# █▄░█ █ ▀▄▀ █▀█ █▀ ▀
# █░▀█ █ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- --

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ../../modules/colors
  
    ../_shared/console

    ./hardware-configuration.nix # virtual
  ];

  boot.loader.grub = {
    device = "/dev/vda";
    configurationLimit = 7;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = with pkgs; lib.mkForce [
      bottom
      curl
      dnsutils
      git
      htop
      ncdu
      neovim
      nitch
      wget
    ];
  };

  networking = {
    hostName = "gliese";
    interfaces = {
      ens3.ipv4.addresses = [{
        address = "89.110.70.126";
        prefixLength = 24;
      }];
    };
    defaultGateway = "89.110.70.1";
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
        port = 22;  # default
      }
    ];
    banner = ''
      █▀▀ █░░ █ █▀▀ █▀ █▀▀
      █▄█ █▄▄ █ ██▄ ▄█ ██▄
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = { 
      admserv = {
        isNormalUser = true;
        description = "Stepan Zhukovsky";
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        packages = with pkgs; [];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtpBAY/JGXUQ8tGhgxvPoffWcK9jNY/B/YmasmN6Ykv gliese.zhukovsky.me"
        ];
      };
      # ... add more users here
    };
  };

  virtualisation.docker.enable = true;

  time.timeZone = "Europe/Amsterdam";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
