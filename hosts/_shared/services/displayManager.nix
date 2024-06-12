# █▀▄ █ █▀ █▀█ █░░ ▄▀█ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ █ ▄█ █▀▀ █▄▄ █▀█ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: 
  let
    extra-pkgs = pkgs.callPackage ../extrapkgs {};
  in {
  services = {
    displayManager = {
      enable = true;
      sddm = { 
        enable = true;
        wayland = {
          enable = true;
        };
        extraPackages = with pkgs; [
          libsForQt5.qt5.qtgraphicaleffects
        ];
        autoNumlock = true;
        theme = "${extra-pkgs.sugar-candy}";
        settings = {
          Theme = { CursorTheme = "catppuccin-mocha-blue-cursors"; };
        };
      };
    };
  };
}
