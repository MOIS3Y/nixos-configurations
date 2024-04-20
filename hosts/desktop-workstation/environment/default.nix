# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, extrapkgs, ... }: {
  environment = {
    variables = {
      # "QT_QPA_PLATFORMTHEME"= "qt5ct";
      "PYTHONDONTWRITEBYTECODE" = "1";
    };
    shells = [ pkgs.bash pkgs.zsh ];
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      # Default pkgs:
      adw-gtk3
      age
      at-spi2-atk  # require for polkit-gnome-authentication-agent-1
      appimage-run
      bottom
      brightnessctl
      catppuccin-cursors.mochaBlue
      # catppuccin-kvantum
      catppuccin-papirus-folders
      cmatrix
      curl
      git
      gradience
      gparted
      htop
      imv
      jq
      libnotify
      (lutris.override {
        extraPkgs = pkgs: with pkgs; [
          winePackages.unstableFull
        ];
      })
      ncdu
      ntfs3g
      neofetch
      neovim
      nitch
      picom
      python311
      python311Packages.pip
      rsync
      sops
      ssh-to-age
      tree
      unzip
      wget
      xdg-utils
      xkb-switch
      # QT5 styles:
      # libsForQt5.qt5ct
      # libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
