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
      awesome = {
        enable = true;
        luaModules = [
          pkgs.lua52Packages.lgi
        ];
      };
      qtile = { 
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
          psutil
          requests
        ];
      };
    };
    videoDrivers = [ "amdgpu" ];
    xkb = {
      variant = "";
      options = "grp:alt_shift_toggle";
      layout = "us,ru";
    };
    deviceSection = ''
      Option "DRI" "3"
      Option "VariableRefresh" "true"
    '';
  };
}
