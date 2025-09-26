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
    # TODO: delete it after finishing renovation
    pamixer
    ddcutil
    hyprsunset
    zenity
  ]
  # optional:
  ++ lib.optionals config.desktop.enable [
    appimage-run
    cursor.package      # ! required for sddm cursor theme
    at-spi2-atk         # !required for polkit-gnome-authentication-agent-1
    adwaita-icon-theme  #! required for most gnome apps
    evince
    firefox
    gnome-calculator
    gnome-calendar
    gnome-online-accounts-gtk
    libnotify
    nautilus
    pavucontrol
    xdg-utils
  ]
  ++ lib.optionals config.desktop.wayland.enable [
    # ? see: https://github.com/NixOS/nixpkgs/issues/280041
    swayosd  # ! required for SwayOSD LibInput Backend
  ]
  ++ lib.optionals config.services.desktopManager.gnome.enable [
    dconf-editor
    gnomeExtensions.auto-move-windows
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.system-monitor
    gnomeExtensions.useless-gaps
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
