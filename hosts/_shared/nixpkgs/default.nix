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
          # Xorg stuff:
          i3lock-run = inputs.i3lock-color-wrapper.packages.${pkgs.stdenv.hostPlatform.system}.i3lock-color-wrapper;
          xidlehook-caffeine = inputs.xidlehook-caffeine.packages.${pkgs.stdenv.hostPlatform.system}.xidlehook-caffeine;
          # Common stuff;
          aladdin4nix = inputs.aladdin4nix.packages.${pkgs.stdenv.hostPlatform.system}.aladdin4nix;
          assets4nix = inputs.assets4nix.packages.${pkgs.stdenv.hostPlatform.system}.assets4nix;
          sddm-sugar-candy = inputs.sddmSugarCandy4Nix.packages.${pkgs.stdenv.hostPlatform.system}.sddm-sugar-candy;
          nvchad = inputs.nvchad4nix.packages.${pkgs.stdenv.hostPlatform.system}.nvchad;
          # Hypr stuff:
          hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          xdg-desktop-portal-hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          hyprlock = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
          hyprsplit = inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit;
        };
      })
    ];
  };
}
