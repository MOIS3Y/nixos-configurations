# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ inputs, config, pkgs, ... }: {
  nixpkgs = { 
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev:{
        extra = {
          # Xorg utils:
          i3lock-run = inputs.i3lock-color-wrapper.packages.${pkgs.stdenv.hostPlatform.system}.i3lock-color-wrapper;
          xidlehook-caffeine = inputs.xidlehook-caffeine.packages.${pkgs.stdenv.hostPlatform.system}.xidlehook-caffeine;
          # Common utils;
          aladdin4nix = inputs.aladdin4nix.packages.${pkgs.stdenv.hostPlatform.system}.aladdin4nix;
          assets4nix = inputs.assets4nix.packages.${pkgs.stdenv.hostPlatform.system}.assets4nix;
          sddm-sugar-candy = inputs.sddmSugarCandy4Nix.packages.${pkgs.stdenv.hostPlatform.system}.sddm-sugar-candy;
          nvchad = inputs.nvchad4nix.packages.${pkgs.stdenv.hostPlatform.system}.nvchad;
        };
      })
    ];
  };
}
