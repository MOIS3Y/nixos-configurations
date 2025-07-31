# █▀▄▀█ █▀▀ █░░ █░░ █▀█ █░█░█   █▀█ █░░ ▄▀█ █▄█ █▀▀ █▀█ ▀
# █░▀░█ ██▄ █▄▄ █▄▄ █▄█ ▀▄▀▄▀   █▀▀ █▄▄ █▀█ ░█░ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

# From custom modules/programs/mellowplayer.nix
# add import ../modules/programs into home.nix before use it.

{ config, pkgs, lib, ... }: {
  programs.mellowplayer = {
    enable = lib.mkDefault config.desktop.enable;
    package = pkgs.mellowplayer;
    settings = {
      General = { zoom = 1;};
      Plex = { favorite = true; };
      Youtube = { favorite = true; };
      "Yandex%20Music" = { favorite = true; };
      main = { close-to-tray = true; };
      notifications = { enabled = true; };
      privacy = { enable-listening-history = true; };
      private = {
        remote-control-enabled = false;
        show-close-to-tray-message = false;
        show-favorite-services = true;
      };
      appearance = with config.colorScheme.palette; {
        theme = "Custom";
        toolbar-visible = true;
        show-tray-icon = true;
        accent = "#${base0D}";
        background = "#${base01}";
        foreground = "#${base05}";
        primary-background = "#${base00}";
        primary-foreground = "#${base05}";
        secondary-background = "#${base00}";
        secondary-foreground = "#${base05}";
      };
    };
  };
}
