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
      substituters = [ "https://mois3y.cachix.org" ];
      trusted-substituters = [ "https://mois3y.cachix.org" ];
      trusted-public-keys = [
        "mois3y.cachix.org-1:DdCvRmrGrXyR+lG9dPP9n+IQh7v6aa/mL2kJ22gFKII="
      ];
    };
  };
}
