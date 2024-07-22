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
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
    };
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland"; # ! required
    };
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    isDesktop = host: if builtins.hasAttr "desktop" host
      then import host.desktop
      else import ./modules/desktop/server.nix;
    # override nixosSystem func for create my NixOS and HM configurations:
    mkNixosSystem = host: lib.nixosSystem {
      specialArgs = {
        inherit system inputs;
        host.desktop = isDesktop host;
      };
      modules = [
        host.configuration
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = {
              inherit system inputs;
              host.desktop = isDesktop host;
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            users = host.users;
          };
        }            
      ];
    };
  in {
    nixosConfigurations = {
      # desktops:
      # -- -- -- -- -- -- -- --
      laptop = mkNixosSystem {
        configuration = ./hosts/desktop-laptop/configuration.nix;
        desktop = ./modules/desktop/laptop.nix;
        users = {
          stepan = ./homes/stepan/home.nix;
        };
      };
      workstation = mkNixosSystem {
        configuration = ./hosts/desktop-workstation/configuration.nix;
        desktop = ./modules/desktop/workstation.nix;
        users = {
          stepan = ./homes/stepan/home.nix;
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
  };
}
