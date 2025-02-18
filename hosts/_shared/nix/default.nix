# █▄░█ █ ▀▄▀ ▀
# █░▀█ █ █░█ ▄
# -- -- -- -- --

{ config, pkgs, ...}: {
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "@wheel" ];
    };
  };
}
