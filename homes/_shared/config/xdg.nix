# ▀▄▀ █▀▄ █▀▀ ▀
# █░█ █▄▀ █▄█ ▄
# -- -- -- -- -
# Configures XDG Base Directories, default applications, and portals.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  # MIME lists:
  # -- -- -- -- -
  web = [
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
    "application/xhtml+xml"
    "application/json"
    "application/pdf"
    "text/html"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/unknown"
  ];

  editor = [
    "application/x-shellscript"
    "text/plain"
    "text/*"
  ];

  archives = [
    "application/x-7z-compressed"
    "application/x-7z-compressed-tar"
    "application/x-ace"
    "application/x-alz"
    "application/x-ar"
    "application/x-arj"
    "application/x-bzip"
    "application/x-bzip-compressed-tar"
    "application/x-bzip1"
    "application/x-bzip1-compressed-tar"
    "application/x-cabinet"
    "application/x-cd-image"
    "application/x-compress"
    "application/x-compressed-tar"
    "application/x-cpio"
    "application/x-deb"
    "application/x-ear"
    "application/x-ms-dos-executable"
    "application/x-gtar"
    "application/x-gzip"
    "application/x-gzpostscript"
    "application/x-java-archive"
    "application/x-lha"
    "application/x-lhz"
    "application/x-lrzip"
    "application/x-lrzip-compressed-tar"
    "application/x-lz4"
    "application/x-lzip"
    "application/x-lzip-compressed-tar"
    "application/x-lzma "
    "application/x-lzma-compressed-tar"
    "application/x-lzop "
    "application/x-lz4-compressed-tar"
    "application/x-lzop-compressed-tar"
    "application/x-ms-wim application/x-rar"
    "application/x-rar-compressed"
    "application/x-rpm"
    "application/x-source-rpm"
    "application/x-rzip"
    "application/x-rzip-compressed-tar"
    "application/x-tar"
    "application/x-tarz"
    "application/x-stuffit"
    "application/x-war"
    "application/x-xz"
    "application/x-xz-compressed-tar"
    "application/x-zip"
    "application/x-zip-compressed"
    "application/x-zoo"
    "application/zip"
    "application/x-archive"
    "application/vnd.ms-cab-compressed"
    "application/vnd.debian.binary-package"
    "application/gzip"
    "compressed/*"
  ];

  # Helper to create associations:
  # -- -- -- -- -- -- -- -- -- -- -
  associate = mimes: app: lib.genAttrs mimes (_: [ app ]);

  # Final mapping:
  # -- -- -- -- -- -
  associations =
    (associate web "firefox.desktop")
    // (associate editor "nvim.desktop")
    // (associate archives "org.gnome.FileRoller.desktop")
    // {
      "inode/directory" = [ "org.gnome.Nautilus.desktop;yazi.desktop" ];
      "video/*" = [ "io.github.celluloid_player.Celluloid.desktop" ];
      "audio/*" = [ "io.bassi.Amberol.desktop" ];
      "audio/mpeg" = [ "io.bassi.Amberol.desktop" ];
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
      "x-scheme-handler/discord" = [ "discord.desktop" ];
      "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
      "x-scheme-handler/mattermost" = [ "Mattermost.desktop" ];
      "x-scheme-handler/magnet" = [ "transmission-gtk.desktop" ];
      "x-scheme-handler/steam" = [ "steam.desktop" ];
      "x-scheme-handler/chrome" = [ "chromium-browser.desktop" ];
    };
in
{
  xdg = {
    enable = true;
    # xdg-user-dirs:
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
      extraConfig = {
        DEVELOPMENT_DIR = "${config.xdg.userDirs.documents}/Projects";
        GAMES_DIR = "${config.home.homeDirectory}/Games";
      };
    };
    # mime types:
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
    # portals:
    portal = {
      enable = true;
      extraPortals = lib.mkForce [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        niri = {
          default = [ "gnome" ];
        };
        common = {
          default = [ "gtk" ];
        };
      };
    };
  };
}
