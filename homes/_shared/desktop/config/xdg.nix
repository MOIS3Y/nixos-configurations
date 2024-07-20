# ▀▄▀ █▀▄ █▀▀ ▀
# █░█ █▄▀ █▄█ ▄
# -- -- -- -- -

{ config, pkgs, ... }: with pkgs.lib;
  let
    # Shortcuts:
    amberol = [ "io.bassi.Amberol.desktop" ];
    browser = [ "firefox.desktop" ];
    chromium-browser = [ "chromium-browser.desktop" ];
    discord = [ "discord.desktop" ];
    file-roller = [ "org.gnome.FileRoller.desktop" ];
    inkscape = [ "org.inkscape.Inkscape.desktop" ];
    imv = [ "imv.desktop" ];
    vlc = [ "vlc.desktop" ];
    mattermost = [ "Mattermost.desktop" ];
    steam = [ "steam.desktop" ];
    telegram = [ "telegramdesktop.desktop" ];
    transmission-gtk = [ "transmission-gtk.desktop" ];
    # Associations:
    associations = {
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "application/json" = browser;
      "application/pdf" = browser;

      "application/x-7z-compressed" = file-roller;
      "application/x-7z-compressed-tar" = file-roller;
      "application/x-ace" = file-roller;
      "application/x-alz" = file-roller;
      "application/x-ar" = file-roller;
      "application/x-arj" = file-roller;
      "application/x-bzip" = file-roller;
      "application/x-bzip-compressed-tar" = file-roller;
      "application/x-bzip1" = file-roller;
      "application/x-bzip1-compressed-tar" = file-roller;
      "application/x-cabinet" = file-roller;
      "application/x-cd-image" = file-roller;
      "application/x-compress" = file-roller;
      "application/x-compressed-tar" = file-roller;
      "application/x-cpio" = file-roller;
      "application/x-deb" = file-roller;
      "application/x-ear" = file-roller;
      "application/x-ms-dos-executable" = file-roller;
      "application/x-gtar" = file-roller;
      "application/x-gzip" = file-roller;
      "application/x-gzpostscript" = file-roller;
      "application/x-java-archive" = file-roller;
      "application/x-lha" = file-roller;
      "application/x-lhz" = file-roller;
      "application/x-lrzip" = file-roller;
      "application/x-lrzip-compressed-tar" = file-roller;
      "application/x-lz4" = file-roller;
      "application/x-lzip" = file-roller;
      "application/x-lzip-compressed-tar" = file-roller;
      "application/x-lzma " = file-roller;
      "application/x-lzma-compressed-tar" = file-roller;
      "application/x-lzop " = file-roller;
      "application/x-lz4-compressed-tar" = file-roller;
      "application/x-lzop-compressed-tar" = file-roller;
      "application/x-ms-wim application/x-rar" = file-roller;
      "application/x-rar-compressed" = file-roller;
      "application/x-rpm" = file-roller;
      "application/x-source-rpm" = file-roller;
      "application/x-rzip" = file-roller;
      "application/x-rzip-compressed-tar" = file-roller;
      "application/x-tar" = file-roller;
      "application/x-tarz" = file-roller;
      "application/x-stuffit" = file-roller;
      "application/x-war" = file-roller;
      "application/x-xz" = file-roller;
      "application/x-xz-compressed-tar" = file-roller;
      "application/x-zip" = file-roller;
      "application/x-zip-compressed" = file-roller;
      "application/x-zoo" = file-roller;
      "application/zip" = file-roller;
      "application/x-archive" = file-roller;
      "application/vnd.ms-cab-compressed" = file-roller;
      "application/vnd.debian.binary-package" = file-roller;
      "application/gzip" = file-roller;

      "text/html" = browser;

      "x-scheme-handler/about" = browser;
      "x-scheme-handler/chrome" = chromium-browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;
      "x-scheme-handler/discord" = discord;
      "x-scheme-handler/tg" = telegram;
      "x-scheme-handler/mattermost" = mattermost;
      "x-scheme-handler/magnet" = transmission-gtk;
      "x-scheme-handler/steam" = steam;

      "compressed/*" = file-roller;
      "video/*" = vlc;
      "audio/*" = amberol;
      "audio/mpeg" = amberol;
      "image/png" = imv;
      "image/jpeg" = imv;
      "image/svg+xml" = inkscape;
      "inode/directory" = [ "org.gnome.Nautilus.desktop;lf.desktop" ];
    };
in {
  xdg = {
    enable = true;
    # xdg-user-dirs:
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DEVELOPMENT_DIR = "${config.xdg.userDirs.documents}/Dev";
        XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
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
    portal = with pkgs; {
      enable = true;
      extraPortals = lib.mkForce ([
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ] ++ (if config.wayland.windowManager.hyprland.enable == true
        then [ pkgs.extra.xdg-desktop-portal-hyprland ]
        else []
      ));
      configPackages = lib.mkForce ([
        gnome.gnome-session
      ] ++ (if config.wayland.windowManager.hyprland.enable == true
        then [ pkgs.extra.hyprland ]
        else []
      ));
      # ? below meaning ~/.config/xdg-desktop-portal/portals.conf:
      # ? [preferred]
      # ? default=gtk
      # ? this overrides the default portal
      # ? may have a negative impact on xdg-desktop-portal-hyprland
      # ? see: https://github.com/nix-community/home-manager/blob/master/modules/misc/xdg-portal.nix
      config = {
        common = {
          default = [ "gtk" ];
        };
      };
    };
  };
}
