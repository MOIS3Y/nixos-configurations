# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
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
    ];
  };
}
