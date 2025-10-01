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
          # Xorg utils:
          i3lock-run = inputs.i3lock-color-wrapper.packages.${pkgs.stdenv.hostPlatform.system}.i3lock-run;
          xidlehook-caffeine = inputs.xidlehook-caffeine.packages.${pkgs.stdenv.hostPlatform.system}.xidlehook-caffeine;
          # Common utils;
          aladdin4nix = inputs.aladdin4nix.packages.${pkgs.stdenv.hostPlatform.system}.aladdin4nix;
          assets4nix = inputs.assets4nix.packages.${pkgs.stdenv.hostPlatform.system}.assets4nix;
          nvchad = inputs.nix4nvchad.packages.${pkgs.stdenv.hostPlatform.system}.nvchad;
        };
      })
    ];
  };
}
