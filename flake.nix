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
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      specialArgs = { inherit system; inherit inputs; };
      extraSpecialArgs = { inherit system; inherit inputs; };
    in {
    nixosConfigurations = {
      desktop-laptop = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/desktop-laptop/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.stepan = import ./homes/stepan_laptop/home.nix;
            };
          }
        ];
      };
      desktop-workstation = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/desktop-workstation/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.stepan = import ./homes/stepan_workstation/home.nix;
            };
          }
        ];
      };
      vps-solar = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/vps-solar/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.admserv = import ./homes/admserv_solar/home.nix;
            };
          }
        ];
      };
      vps-gliese = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/vps-gliese/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.admserv = import ./homes/admserv_gliese/home.nix;
            };
          }
        ];
      };
      vps-allsave = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/vps-allsave/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.admserv = import ./homes/admserv_allsave/home.nix;
            };
          }
        ];
      };
      # ... add more hosts here:
    };
  };
}
