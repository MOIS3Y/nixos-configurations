# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: 
  let
    extrapkgs = pkgs.callPackage ../extrapkgs {};
  in {
  services.xserver = {
    enable = true;
    displayManager = { 
      sddm = { 
        enable = true;
        theme = "${extrapkgs.sugar-candy}";
      };
    };
    windowManager = {
      awesome.enable = true;
      qtile = { 
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          qtile-extras
          psutil
          requests
        ];
      };
    };
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle";
    xkbVariant = "";
  };
}
