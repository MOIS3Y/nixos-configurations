# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, extrapkgs, ... }: {
  environment = {
    variables = {
      "QT_QPA_PLATFORMTHEME"= "qt5ct";
      "PYTHONDONTWRITEBYTECODE" = "1";
    };
    shells = [ pkgs.bash pkgs.zsh ];
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      # Default pkgs:
      adw-gtk3
      at-spi2-atk  # require for polkit-gnome-authentication-agent-1
      bottom
      brightnessctl
      catppuccin-cursors
      catppuccin-kvantum
      catppuccin-papirus-folders
      curl
      git
      gradience
      gparted
      htop
      i3lock-color
      jq
      libnotify
      ncdu
      ntfs3g
      neofetch
      neovim
      picom
      (python311.withPackages(ps: with ps; [ requests psutil ]))
      python311Packages.pip
      (ranger.override { imagePreviewSupport = true; })
      rsync
      tree
      unzip
      ueberzug
      wget
      w3m
      xdg-utils
      xidlehook
      xkb-switch
      xdragon
      # QT5 styles:
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5.qtgraphicaleffects
      # Home managment:
      home-manager
      # Extra-pkgs:
      extrapkgs.i3lock-run
      extrapkgs.xidlehook-caffeine
    ];
  };
}
