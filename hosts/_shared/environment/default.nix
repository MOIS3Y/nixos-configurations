# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: {
  environment = {
    variables = {
      "PYTHONDONTWRITEBYTECODE" = "1";
    };
    shells = [
      pkgs.bash
      pkgs.zsh
    ];
    pathsToLink = [
      "/libexec"
    ];
    systemPackages = with pkgs; [
      # common:
      bottom
      cmatrix
      curl
      dnsutils
      docker-compose
      git
      htop
      jq
      lm_sensors
      ncdu
      neofetch
      nitch
      nmap
      ntfs3g
      parted
      rsync
      ripgrep
      tree
      tty-clock
      wget
      unzip
    ] ++ lib.optionals (config.desktop or null != null) [
      # desktop:
      appimage-run
      firefox
      libnotify
      pavucontrol
      xdg-utils
      config.desktop.cursor.package  # ! required for sddm cursor theme
    ];
  };
}
