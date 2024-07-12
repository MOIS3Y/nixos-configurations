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
      age
      # appimage-run
      bottom
      cmatrix
      curl
      dnsutils
      docker-compose
      git
      htop
      jq
      # imv
      lm_sensors
      ncdu
      # ! neofetch breaks the build since Jul 10 2024
      # ? see: https://discourse.nixos.org/t/error-nose-1-3-7-not-supported-for-interpreter-python3-12/48703/9
      # ? and https://github.com/NixOS/nixpkgs/issues/325657
      # neofetch
      nitch
      nmap
      ntfs3g
      # (lua.withPackages(ps: with ps; [ luarocks ]))
      # (python3.withPackages(ps: with ps; [ pip ]))
      rsync
      ripgrep
      sops
      ssh-to-age
      tree
      tty-clock
      wget
      unzip
    ];
  };
}
