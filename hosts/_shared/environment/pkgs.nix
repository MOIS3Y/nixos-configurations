# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█   █▀█ ▄▀█ █▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█   █▀▀ █▀█ █▄▄ █░█ █▀█ █▄█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  inherit (config.desktop)
    cursor
    games;
  inherit (config.host)
    hardware
    virtualisation;
in {
  environment.systemPackages = with pkgs; [
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
  ]
  # optional:
  ++ lib.optionals config.desktop.enable [
    appimage-run
    cursor.package  # ! required for sddm cursor theme
    firefox
    libnotify
    pavucontrol
    xdg-utils
  ]
  ++ lib.optionals (config.desktop.enable && games.enable) games.extraPackages
  ++ lib.optionals (config.desktop.enable && hardware.gpu.enable) [
    amdgpu_top
    lact
    nvtopPackages.amd    
  ]
  ++ lib.optionals (config.desktop.enable && virtualisation.libvirtd.enable) [
    virt-manager
  ];
}
