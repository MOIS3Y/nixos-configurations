# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- --

{ inputs, pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev:{
        extra = {
          aladdin4nix = inputs.aladdin4nix.packages.${pkgs.stdenv.hostPlatform.system}.aladdin4nix;
          assets4nix = inputs.assets4nix.packages.${pkgs.stdenv.hostPlatform.system}.assets4nix;
          nvchad = inputs.nix4nvchad.packages.${pkgs.stdenv.hostPlatform.system}.nvchad;
        };
      })
    ];
  };
}
