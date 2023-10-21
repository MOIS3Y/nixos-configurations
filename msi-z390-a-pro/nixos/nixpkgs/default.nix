# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, extrapkgs, ... }: {
  nixpkgs = { 
    config = {
      allowUnfree = true;
    };
    overlays = [
      (_: prev: {
        steam = prev.steam.override {
          extraProfile = ''
            export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${extrapkgs.proton-ge}'
          '';
        };
      })
    ];
  };
}
