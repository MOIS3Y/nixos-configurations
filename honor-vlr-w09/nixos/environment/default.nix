# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ...}: {

  environment = {
    variables = {
      "QT_QPA_PLATFORMTHEME"= "qt5ct";
      "PYTHONDONTWRITEBYTECODE" = "1";
    };
    shells = [ pkgs.bash pkgs.zsh ];
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      # Default pkgs:
      bottom
      curl
      git
      htop
      jq
      neofetch
      neovim
      python311
      python311Packages.pip
      rsync
      tree
      unzip
      wget
      # Tray icons:
      indicator-application-gtk3
      # QT5 styles:
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      # Home managment:
      home-manager
    ];
  };
}
