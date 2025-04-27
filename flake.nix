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
  
  outputs = { nixpkgs, home-manager, nix-on-droid, ... }@inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    # ! -- -- -- -- -- Linux -- -- -- -- -- ! #
    nixosConfigurations = {
      # desktops:
      # -- -- -- -- -- -- -- --
      laptop = lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        modules = [
          ./hosts/desktop-laptop/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = {
                inherit system inputs;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                stepan = ./homes/stepan/home-on-laptop.nix;
              };
            };
          }
        ];
      };
      workstation = lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        modules = [
          ./hosts/desktop-workstation/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = {
                inherit system inputs;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                stepan = ./homes/stepan/home-on-workstation.nix;
              };
            };
          }
        ];
      };
      # servers:
      # -- -- -- -- -- -- -- --
      allsave = lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        modules = [
          ./hosts/server-allsave/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = {
                inherit system inputs;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                admserv = ./homes/admserv/home.nix;
              };
            };
          }
        ];
      };
      # vps:
      # -- -- -- -- -- -- -- --
      gliese = lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        modules = [
          ./hosts/vps-gliese/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = {
                inherit system inputs;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                admvps = ./homes/admvps/home.nix;
              };
            };
          }
        ];
      };
      solar = lib.nixosSystem {
        specialArgs = {
          inherit system inputs;
        };
        modules = [
          ./hosts/vps-solar/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              extraSpecialArgs = {
                inherit system inputs;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                admvps = ./homes/admvps/home.nix;
              };
            };
          }
        ];
      };
    };
    # ! -- -- -- -- -- Android -- -- -- -- -- ! #
    nixOnDroidConfigurations = {
      # primary
      # -- -- -- --
      pixel = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [
          ./hosts/phone-pixel/nix-on-droid.nix
        ];
        # for nix-on-droid:
        extraSpecialArgs = {
          inherit inputs;
          home-config = {
            config = ./homes/nix-on-droid/home.nix;
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
    };
  };
}
