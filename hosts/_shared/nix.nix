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
      extra-substituters = [ "https://mois3y.cachix.org" ];
      extra-trusted-public-keys = [
        "mois3y.cachix.org-1:DdCvRmrGrXyR+lG9dPP9n+IQh7v6aa/mL2kJ22gFKII="
      ];
      trusted-users = [ "@wheel" ];
    };
  };
}
