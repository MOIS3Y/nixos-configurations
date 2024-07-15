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
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    # Default desktop configurations:
    desktopConf = {
      pc = {
        enable = true;
        laptop.enable = false;
      };
      laptop = {
        enable = true;
        laptop.enable = true;
      };
      server = {
        enable = false;
        laptop.enable = false;
      };
    };
    # override nixosSystem func for create my NixOS and HM configurations:
    mkNixosSystem = host: lib.nixosSystem {
      specialArgs = {
        inherit system inputs;
        desktop = lib.attrsets.attrByPath [ host.type ] "server" desktopConf;
      };
      modules = [
        host.configuration
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = {
              inherit system inputs;
              desktop = lib.attrsets.attrByPath [ host.type ] "server" desktopConf;
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
      desktop-laptop = mkNixosSystem {
        configuration = ./hosts/desktop-laptop/configuration.nix;
        type = "laptop";
        users = {
          stepan = ./homes/stepan/home.nix;
        };
      };
      desktop-workstation = mkNixosSystem {
      configuration = ./hosts/desktop-workstation/configuration.nix;
        type = "pc";
        users = {
          stepan = ./homes/stepan/home.nix;
        };
      };
      vps-allsave = mkNixosSystem {
        configuration = ./hosts/server-allsave/configuration.nix;
        type = "server";
        users = {
          admserv = ./homes/admserv/home.nix;
        };
      };
      vps-gliese = mkNixosSystem {
        configuration = ./hosts/vps-gliese/configuration.nix;
        type = "server";
        users = {
          admvps = ./homes/admvps/home.nix;
        };
      };
      vps-solar = mkNixosSystem {
        configuration = ./hosts/vps-solar/configuration.nix;
        type = "server";
        users = {
          admvps = ./homes/admvps/home.nix;
        };
      };
      # ... add more hosts here:
    };
  };
}
