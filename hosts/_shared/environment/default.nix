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
    ] ++ lib.optionals config.desktop.enable [
      # desktop:
      appimage-run
      config.desktop.cursor.package  # ! required for sddm cursor theme
      firefox
      libnotify
      pavucontrol
      xdg-utils
    ] ++ lib.optionals config.host.hardware.gpu.enable [
      amdgpu_top
      lact
      nvtopPackages.amd
    ] ++ lib.optionals config.host.virtualisation.libvirtd.enable [
      virt-manager
    ] ++ lib.optionals config.desktop.games.enable 
    config.desktop.games.extraPackages;
  };
}
