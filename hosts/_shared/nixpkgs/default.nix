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
          i3lock-run = inputs.i3lock-color-wrapper.packages."${pkgs.system}".i3lock-color-wrapper;
          xidlehook-caffeine = inputs.xidlehook-caffeine.packages."${pkgs.system}".xidlehook-caffeine;
          aladdin4nix = inputs.aladdin4nix.packages."${pkgs.system}".aladdin4nix;
          assets4nix = inputs.assets4nix.packages."${pkgs.system}".assets4nix;
          sddm-sugar-candy = inputs.sddmSugarCandy4Nix.packages."${pkgs.system}".sddm-sugar-candy;
          nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
        };
      })
    ];
  };
}
