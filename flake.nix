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
    i3lock-color-wrapper.url = "github:MOIS3Y/i3lock-color-wrapper";
    xidlehook-caffeine.url = "github:MOIS3Y/xidlehook-caffeine";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      specialArgs = { inherit system; inherit inputs; };
    in {
    nixosConfigurations = {
      # laptop:
      honor-wlr-w09 = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./honor-vlr-w09/nixos/configuration.nix
        ];
      };
      # workstation:
      msi-z390-a-pro = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./msi-z390-a-pro/nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.stepan = import ./msi-z390-a-pro/home/stepan/home.nix;
            };
          }
        ];
      };
      # dev:
      vps-gliese = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./vps-gliese/nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.admserv = import ./vps-gliese/home/admserv/home.nix;
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
          ./honor-vlr-w09/home/stepan/home.nix
        ];
      };
      # ... add more users here:
    };
  };
}
