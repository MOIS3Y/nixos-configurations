# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  environment = {
    variables = {
      "PYTHONDONTWRITEBYTECODE" = "1";
    };
    shells = [ pkgs.bash pkgs.zsh ];
    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      # Default pkgs:
      adw-gtk3
      age
      appimage-run
      bottom
      brightnessctl
      catppuccin-cursors.mochaBlue
      cmatrix
      curl
      dnsutils
      docker-compose
      gettext
      git
      gparted
      htop
      imv
      jq
      libnotify
      lm_sensors
      lua
      ncdu
      nmap
      ntfs3g
      neofetch
      neovim
      nitch
      pavucontrol
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
    ];
  };
}
