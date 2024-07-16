# █▀▄ █ █▀ █▀█ █░░ ▄▀█ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ █ ▄█ █▀▀ █▄▄ █▀█ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
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
        theme = with config.colorScheme.palette; ''${
          pkgs.extra.sddm-sugar-candy.override {
            settings = {
              Background = "${config.desktop.assets.images.background}";
              ScreenWidth = "1920";
              ScreenHeight = "1080";
              MainColor = "#${base05}";
              AccentColor = "#${base0D}";
              BackgroundColor = "#${base01}";
              OverrideLoginButtonTextColor = "#${base01}";
              Font = "Ubuntu";
              DateFormat = "dddd, d MMMM yyyy";
              HeaderText = "NixOS";
              FormPosition="center";
              FullBlur=true;
            };
          }
        }'';
        settings = {
          Theme = { CursorTheme = "catppuccin-mocha-blue-cursors"; };
        };
      };
    };
  };
}
