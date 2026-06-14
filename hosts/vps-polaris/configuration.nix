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
      device = "/dev/sda";
      configurationLimit = 7;
    };
    kernelParams = [
      "console=tty0"
      "console=ttyS0,115200"
    ];
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
      extra.xraymgr
    ];
  };

  networking = {
    hostName = "polaris";
    useDHCP = true;
    useNetworkd = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
      allowedUDPPorts = [
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
    settings.trusted-users = [ "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      extra = {
        nvchad = inputs.nix4nvchad.packages."${pkgs.stdenv.hostPlatform.system}".nvchad;
        xraymgr = inputs.xraymgr.packages."${pkgs.stdenv.hostPlatform.system}".default;
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

    qemuGuest.enable = true;
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

  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "26.05";
}
