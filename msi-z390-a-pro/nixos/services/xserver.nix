# ▀▄▀ █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ ▀
# █░█ ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: 
  let
    extra-pkgs = pkgs.callPackage ../extrapkgs {};
  in {
  services.xserver = {
    enable = true;
    displayManager = {
      sddm = { 
        enable = true;
        autoNumlock = true;
        theme = "${extra-pkgs.sugar-candy}";
        settings = {
          Theme = { CursorTheme = "Catppuccin-Mocha-Blue-Cursors"; };
        };
      };
    };
    windowManager = {
      awesome.enable = true;
      qtile = { 
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          psutil
          requests
        ];
      };
    };
    videoDrivers = [ "amdgpu" ];
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle";
    xkbVariant = "";
    deviceSection = ''
      Option "DRI" "3"
      Option "VariableRefresh" "true"
    '';
  };
}
