# █▀▄ █ █▀ █▀█ █░░ ▄▀█ █▄█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▄▀ █ ▄█ █▀▀ █▄▄ █▀█ ░█░   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: let
  # shortcuts:
  wallpapers = "${pkgs.extrapkgs.assets4nix}/share/wallpapers";
  cs = "${config.colorScheme.name}";
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
        theme = ''${
          pkgs.extrapkgs.sddm-sugar-candy.override {
            settings = {
              Background = ''${wallpapers}/hexagon_empty_darker/${cs}.png'';
              ScreenWidth = "1920";
              ScreenHeight = "1080";
              MainColor = "#${config.colorScheme.palette.base05}";
              AccentColor = "#${config.colorScheme.palette.base0D}";
              BackgroundColor = "#${config.colorScheme.palette.base01}";
              OverrideLoginButtonTextColor = "#${config.colorScheme.palette.base01}";
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
