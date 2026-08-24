# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- --
# Sets up nixpkgs overlays and unfree config.

{
  inputs,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev: {
        extra = {
          aladdin-nix = inputs.aladdin-nix.packages.${system}.default;
          assets4nix = inputs.assets4nix.packages.${system}.default;
          dion-nix = inputs.dion-nix.packages.${system}.default;
          nvchad = inputs.nix4nvchad.packages.${system}.default;
          mdgreet = inputs.mdgreet.packages.${system}.default;
        };
      })
    ];
  };
}
