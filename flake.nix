# █▀▄▀█ ▄▀█ █ █▄░█   █▀▀ █░░ ▄▀█ █▄▀ █▀▀ ▀
# █░▀░█ █▀█ █ █░▀█   █▀░ █▄▄ █▀█ █░█ ██▄ ▄
# https://github.com/MOIS3Y/nixos-configurations
# -- -- -- -- -- -- -- -- -- -- -- -- -- -

{
  description = "NixOS configurations for my devices";
  
  inputs = {
    # Default:
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Android:
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    # Extra:
    i3lock-color-wrapper = {
      url = "github:MOIS3Y/i3lock-color-wrapper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xidlehook-caffeine = {
      url = "github:MOIS3Y/xidlehook-caffeine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
      # inputs.base16-schemes.follows = "base16-schemes";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    distro-grub-themes = {
      url = "github:AdisonCavani/distro-grub-themes";
    };
    aladdin4nix = {
      url = "github:MOIS3Y/aladdin4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    assets4nix = {
      url = "github:MOIS3Y/assets4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sddmSugarCandy4Nix = {
      url = "github:MOIS3Y/sddmSugarCandy4Nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad4nix = {
      url = "github:MOIS3Y/nvchad4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad-on-steroids = {
      url = "github:MOIS3Y/nvchad-on-steroids";
      flake = false;
    };
    kvlibadwaita = {
      url = "github:MOIS3Y/KvLibadwaita?ref=gradience";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, nix-on-droid, ... }@inputs: let
    # Default system:
    system = "x86_64-linux";
    # Shortcut:
    lib = nixpkgs.lib;
    # Need for first install from flake:
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    # Helpers:
    # override nixosSystem func for create my NixOS and HM configurations:
    mkNixosSystem = host: lib.nixosSystem {
      specialArgs = {
        inherit system inputs;
      };
      modules = [
        host.configuration
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = {
              inherit system inputs;
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            users = host.users;
          };
        }            
      ];
    };
    # override nixOnDroidConfiguration func for android setup:
    mkNixOnDroidSystem = host: nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [
        host.configuration
      ];
      # for nix-on-droid:
      extraSpecialArgs = {
        inherit inputs;
        home-config = {
          config = host.home;
          backupFileExtension = "hm-bak";
          useGlobalPkgs = true;
          # for hm:
          extraSpecialArgs = { inherit inputs; };
        };
      };
      pkgs = import nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };
    };
  in {
    # Linux:
    nixosConfigurations = {
      # desktops:
      # -- -- -- -- -- -- -- --
      laptop = mkNixosSystem {
        configuration = ./hosts/desktop-laptop/configuration.nix;
        users = {
          stepan = ./homes/stepan/home-on-laptop.nix;
        };
      };
      workstation = mkNixosSystem {
        configuration = ./hosts/desktop-workstation/configuration.nix;
        users = {
          stepan = ./homes/stepan/home-on-workstation.nix;
        };
      };
      # servers:
      # -- -- -- -- -- -- -- --
      allsave = mkNixosSystem {
        configuration = ./hosts/server-allsave/configuration.nix;
        users = {
          admserv = ./homes/admserv/home.nix;
        };
      };
      # vps:
      # -- -- -- -- -- -- -- --
      gliese = mkNixosSystem {
        configuration = ./hosts/vps-gliese/configuration.nix;
        users = {
          admvps = ./homes/admvps/home.nix;
        };
      };
      solar = mkNixosSystem {
        configuration = ./hosts/vps-solar/configuration.nix;
        users = {
          admvps = ./homes/admvps/home.nix;
        };
      };
    };
    # Android:
    nixOnDroidConfigurations = {
      # primary
      # -- -- -- -- -- -- -- -- --
      pixel = mkNixOnDroidSystem {
        configuration = ./hosts/phone-pixel/nix-on-droid.nix;
        home = ./homes/nix-on-droid/home.nix;
      };
    };
  };
}
