# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- --

{ inputs, system, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev: {
        extra = {
          aladdin4nix = inputs.aladdin4nix.packages.${system}.aladdin4nix;
          assets4nix = inputs.assets4nix.packages.${system}.assets4nix;
          nvchad = inputs.nix4nvchad.packages.${system}.nvchad;
          mdgreet = inputs.mdgreet.packages.${system}.default;
        };
      })
    ];
  };
}
