# █▀▄ █▀▀ █▀█ █▄░█ █▀▀ ▀
# █▄▀ █▄▄ █▄█ █░▀█ █▀░ ▄
# -- -- -- -- -- -- -- -- --
# Configures dconf settings for GNOME, Virt-Manager and system theming.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
in
{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    "org/gnome/desktop/interface" = {
      accent-color = "blue";
      color-scheme = if mode == "dark" then "prefer-dark" else "default";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://${config.assets.backgrounds.cat-leaves}";
      picture-uri-dark = "file://${config.assets.backgrounds.cat-leaves}";
      primary-color = palette.blue;
      secondary-color = palette.magenta;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      num-workspaces = 9;
      theme = "Adwaita"; # TODO: create custom
    };
    "org/gnome/desktop/input-sources" = {
      sources = lib.gvariant.mkArray [
        (lib.gvariant.mkTuple [
          "xkb"
          "us"
        ])
        (lib.gvariant.mkTuple [
          "xkb"
          "ru"
        ])
      ];
      xkb-options = [ "grp:alt_shift_toggle" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      # workspaces
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];

      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];
      move-to-workspace-7 = [ "<Shift><Super>7" ];
      move-to-workspace-8 = [ "<Shift><Super>8" ];
      move-to-workspace-9 = [ "<Shift><Super>9" ];
      # window
      close = [ "<Super>w" ];
    };
    "org/gnome/desktop/privacy" = {
      remember-app-usage = false; # ? not recorded mimeapps.list
    };
    "org/gnome/shell" = {
      favorite-apps = [
        # TODO: create list from config.desktop.apps
        "firefox.desktop"
        "org.gnome.Console.desktop"
        "org.telegram.desktop.desktop"
        "code.desktop"
        "steam.desktop"
        "com.usebottles.bottles.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Nautilus.desktop"
        "org.coolercontrol.CoolerControl.desktop"
      ];
      enabled-extensions = [
        pkgs.gnomeExtensions.auto-move-windows.extensionUuid
        pkgs.gnomeExtensions.appindicator.extensionUuid
        pkgs.gnomeExtensions.caffeine.extensionUuid
        pkgs.gnomeExtensions.system-monitor.extensionUuid
        pkgs.gnomeExtensions.useless-gaps.extensionUuid
      ];
    };
    "org/gnome/shell/extentions/useless-gaps" = {
      gap-size = 8;
    };
    "org/gnome/shell/keybindings" = {
      # disable conflict with workspaces
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
    };
  };
}
