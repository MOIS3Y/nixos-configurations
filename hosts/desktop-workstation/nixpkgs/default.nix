# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, inputs, ... }: {
  nixpkgs = { 
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev:
      let
        i3lock-run = inputs.i3lock-color-wrapper.packages."${pkgs.system}".i3lock-color-wrapper;
        xidlehook-caffeine = inputs.xidlehook-caffeine.packages."${pkgs.system}".xidlehook-caffeine;
        aladdin4nix = inputs.aladdin4nix.packages."${pkgs.system}".aladdin4nix;
      in {
        extrapkgs = {
          inherit i3lock-run;
          inherit xidlehook-caffeine;
          inherit aladdin4nix;
        };
      })
    ];
  };
}
