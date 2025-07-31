# █▀▄ █ █▀ █▀█ █░░ ▄▀█ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ █ ▄█ █▀▀ █▄▄ █▀█ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: let
  cfg = config.desktop;
  inherit (config.colorScheme)
    palette;
  in {
  services = {
    displayManager = {
      enable = cfg.displayManager.enable;
      sddm = { 
        enable = cfg.displayManager.sddm.enable;
        wayland = {
          enable = cfg.wayland.enable;
        };
        extraPackages = [
          pkgs.libsForQt5.qt5.qtgraphicaleffects
          cfg.cursor.package  #? not working add it in systemPackages
        ];
        autoNumlock = true;
        theme = ''${
          pkgs.extra.sddm-sugar-candy.override {
            settings = {
              Background = "${cfg.assets.images.background}";
              ScreenWidth = "1920";
              ScreenHeight = "1080";
              MainColor = "#${palette.base05}";
              AccentColor = "#${palette.base0D}";
              BackgroundColor = "#${palette.base01}";
              OverrideLoginButtonTextColor = "#${palette.base01}";
              Font = "Ubuntu";
              DateFormat = "dddd, d MMMM yyyy";
              HeaderText = "NixOS";
              FormPosition="center";
              FullBlur=true;
            };
          }
        }'';
        settings = {
          Theme = { CursorTheme = cfg.cursor.name; };
        };
      };
    };
  };
}
