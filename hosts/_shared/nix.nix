# █▄░█ █ ▀▄▀ ▀
# █░▀█ █ █░█ ▄
# -- -- -- -- --
# Configures Nix daemon and flakes settings.

{ pkgs, ... }:
{
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
