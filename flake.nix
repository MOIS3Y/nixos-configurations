# █▀▄▀█ ▄▀█ █ █▄░█   █▀▀ █░░ ▄▀█ █▄▀ █▀▀ ▀
# █░▀░█ █▀█ █ █░▀█   █▀░ █▄▄ █▀█ █░█ ██▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{
  description = "NixOS configurations for my devices";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      honor-wlr-w09 = lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./honor-vlr-w09/nixos/configuration.nix
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
