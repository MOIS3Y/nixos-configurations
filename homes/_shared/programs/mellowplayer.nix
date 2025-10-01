# █▀▄▀█ █▀▀ █░░ █░░ █▀█ █░█░█   █▀█ █░░ ▄▀█ █▄█ █▀▀ █▀█ ▀
# █░▀░█ ██▄ █▄▄ █▄▄ █▄█ ▀▄▀▄▀   █▀▀ █▄▄ █▀█ ░█░ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

# From custom modules/programs/mellowplayer.nix
# add import ../modules/programs into home.nix before use it.

{ config, pkgs, lib, ... }: {
  programs.mellowplayer = {
    #! broken qtwebengine-5.15.19 CVE-2025-6558
    #? see: https://github.com/NixOS/nixpkgs/issues/438881
    # enable = lib.mkDefault config.desktop.enable;
    enable = lib.mkDefault false;
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
