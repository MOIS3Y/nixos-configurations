# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, extrapkgs, ... }: {
  nixpkgs = { 
    config = {
      allowUnfree = true;
    };
  };
}
