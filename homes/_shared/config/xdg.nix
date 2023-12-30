# ▀▄▀ █▀▄ █▀▀ ▀
# █░█ █▄▀ █▄█ ▄
# -- -- -- -- -

{ config, pkgs, ... }: with pkgs.lib;
  let
    browser = [ "firefox.desktop" ];
    associations = {
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "application/json" = browser;
      "application/pdf" = browser;

      "text/html" = browser;

      "x-scheme-handler/about" = browser;
      "x-scheme-handler/chrome" = [ "chromium-browser.desktop" ];
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;
      "x-scheme-handler/discord" = [ "discord.desktop" ];
      "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
      "x-scheme-handler/mattermost" = [ "Mattermost.desktop" ];
      "x-scheme-handler/steam" = [ "steam.desktop" ];

      "audio/*" = [ "vlc.desktop" ];
      "video/*" = [ "vlc.dekstop" ];
      "image/*" = [ "imv.desktop" ];

      "inode/directory" = [ "lf.desktop" ];
    };
in {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DEVELOPMENT_DIR = "${config.xdg.userDirs.documents}/Dev";
        XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
      };
    };
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
