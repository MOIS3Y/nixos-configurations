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
    hypridle = {
      url = "github:hyprwm/hypridle";
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
      # laptop:
      honor-wlr-w09 = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/honor-vlr-w09/configuration.nix
        ];
      };
      # workstation:
      msi-z390-a-pro = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/msi-z390-a-pro/configuration.nix
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
      # general:
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
      # dev:
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
      # lab:
      vps-allsave = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/vps-allsave/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.admserv = import ./homes/admserv_allsave/home.nix;
            };
          }
        ];
      };
      # ... add more hosts here:
    };
    homeConfigurations = {
      "stepan@honor-vlr-w09" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./homes/stepan_laptop/home.nix
        ];
      };
      # ... add more users here:
    };
  };
}
