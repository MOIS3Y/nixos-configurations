# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
# Provides basic shell, environment variables and common system packages.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.desktop) compositors cursor games;
  inherit (config) virtualisation;
in
{
  environment.systemPackages =
    with pkgs;
    [
      # common:
      bottom
      cmatrix
      curl
      dnsutils
      docker-compose
      duf
      git
      htop
      jq
      lm_sensors
      ncdu
      fastfetch
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
      adwaita-icon-theme # ! required for most gnome apps
      dux-calendar
      dux-files
      dux-gop
      evince
      file-roller
      firefox
      gnome-calculator
      libnotify
      pavucontrol
      pywalfox-native
      xdg-utils
      xwayland-satellite
      cursor.package # ! required for mdgreet
      extra.assets4nix
      libsForQt5.qt5ct
      qt6Packages.qt6ct
    ]
    ++ lib.optionals config.services.desktopManager.gnome.enable [
      dconf-editor
      nautilus
      gnomeExtensions.auto-move-windows
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.system-monitor
      gnomeExtensions.useless-gaps
    ]
    # Dux Shell plugin dependencies:
    ++ lib.optionals (compositors != [ ]) [
      ffmpeg
      gpu-screen-recorder
      imagemagick
      img2pdf
      tesseract
      wf-recorder
      zbar
    ]
    ++ lib.optionals (config.desktop.enable && games.enable) games.extraPackages
    ++ lib.optionals (config.desktop.enable && config.services.lact.enable) [
      amdgpu_top
      lact
      nvtopPackages.amd
    ]
    ++ lib.optionals (config.desktop.enable && virtualisation.libvirtd.enable) [ virt-manager ];

  environment.shells = [
    pkgs.bash
    pkgs.zsh
  ];
  environment.variables = {
    "PYTHONDONTWRITEBYTECODE" = "1";
  };
  environment.pathsToLink = [ "/share/backgrounds" ];
}
