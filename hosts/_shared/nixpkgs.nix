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
          aladdin4nix = inputs.aladdin4nix.packages.${system}.default;
          assets4nix = inputs.assets4nix.packages.${system}.default;
          nvchad = inputs.nix4nvchad.packages.${system}.default;
          mdgreet = inputs.mdgreet.packages.${system}.default;
        };
      })
    ];
  };
}
